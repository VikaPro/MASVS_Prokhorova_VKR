#include "selectproject.h"

#include <QDateTime>
#include <QFile>
#include <QDir>
#include <QProcess>

QString nameProject;


SelectProject::SelectProject(QObject *QMLObject) : viewer(QMLObject)
{
    projects_model = new ProjectsModel();       // модель для существующих проектов
    reports_model = new ReportsModel();         // модель для отчёта по проекту
    console = new QProcess(this);

}


void SelectProject::checkNameProject(QString name){
    // Проверяем, есть ли каталог проекта с таким же именем
    bool project_exists = QDir("C:/MASVS/" + name).exists();
    if (project_exists == true){
        emit projectExists(name);
    }

    else{
        emit newProject();
        // Вызываем функцию для создания директории и файлов нового проекта
        nameNewProject(name);
    }
}

void SelectProject::nameNewProject(QString name){
    QDate now = QDate::currentDate();
    QString dateStr = now.toString("dd-MM-yyyy");

    // Создание каталога для нового проекта
    QString path("C:/MASVS/" + name);
    QDir dir;
    dir.mkpath(path);

    // Файл, в котором будет храниться основная информация для программы
    // Конфигурационный файл с именем «название_проекта.conf»
    QFile file_conf(path + "/" + name + ".conf");
    file_conf.open(QIODevice::WriteOnly | QIODevice::Text
              | QIODevice::Append );
    QTextStream str(&file_conf);
    str.setCodec("UTF-8");

    str << "Project name: " << name << endl;        // записываем название проекта
    str << "Creation date: " << dateStr << endl;    // записываем дату создания
    str << "Modified date: " << dateStr << endl;    // записываем дату изменения, которая на момент создания совпадает с верхней

    file_conf.close();

    nameProject = name;     // присваиваем глобальной переменной название текущего проекта
}

void SelectProject::downloadApk(QString apk){
    // Удаляем ненужные символы из пути к файлу, которые прислала графика
    apk.remove("file:///");

    // Записываем в конфигурационный файл с именем «название_проекта.conf»
    QFile file_conf("C:/MASVS/" + nameProject + "/" + nameProject + ".conf");
    file_conf.open(QIODevice::ReadWrite | QIODevice::Text);
              //| QIODevice::Append );
    QTextStream stream(&file_conf);
    stream.setCodec("UTF-8");

    // Записываем в файл проекта, какой стиль входных данных был выбран
    // Если ранее стоял другой тип, значит перезаписываем это значение на текущее
    QString type_input = "Только APK";

    // Затем записываем в конфиг проекта, какой файл apk мы взяли для анализа, чтобы имя потом не потерялось
    // Для этого проверяем, не стояло ли там уже какое-либо значение,
    // если строка заполнена, то удаляем её содержимое и пишем новое
    QString str;
    while(!stream.atEnd()){
        QString line = stream.readLine();
        if(line.contains("Input data: ") || line.contains("APK path: ")){
            qDebug() << "Перезаписываем следующие значения в конфиге проекта: " << line;
        }
        else{
            str.append(line + "\n");
        }
    }

    file_conf.resize(0);
    stream << str;
    stream << "Input data: " << type_input << endl; // записываем тип входных данных в конфиг файла
    stream << "APK path: " << apk << endl;          // записываем новый путь к файлу apk в конец конфига проекта
    file_conf.close();


    // Проверяем, что в каталоге не лежит никаких лишних файлов, помимо основного файла проекта,
    // если такие есть, то удаляем их, потому что они относятся к старому выбору пользователя
    QString path = "C:/MASVS/" + nameProject;
    QString conf = nameProject + ".conf";
    QDir dir(path);

    QStringList	listProject = dir.entryList(QDir::Files);

    for (int i = 0;  i < listProject.size(); i++){
        if(listProject[i] != conf){                         // если это не главный файл проекта
            QFile::remove(path + "/" + listProject[i]);     // то удаляем его
        }
    }

    // Затем копируем выбранный файл apk внутрь нашего проекта
    // Переименовываем для простоты использования в «название_проекта.apk»
    QString  file_apk = "C:/MASVS/" + nameProject + "/" + nameProject + ".apk";
    QFile::copy(apk, file_apk);

    // вызываем функцию декомпиляции файла apk
    decompileApk();

    // если файл успешно декомпилирован, то оповещаем графику, что мы успешно загрузили apk и можно продолжить
    connect(this, SIGNAL(endDecompile()), this, SIGNAL(downloadedApk()));

    // в случае неудачи декомпиляции оповещаем графику, что с файлом проблемы, нужно его изменить
    connect(this, SIGNAL(errorDecompile()), this, SIGNAL(errorApk()));

    // этот сигнал нужен, чтобы страничка с уровнями понимала, куда ей "вернуться"
    emit selectLevel("apk");
}


void SelectProject::decompileApk(){

    QString pathProject = "C:/MASVS/" + nameProject + "/" + nameProject + "_apk";
    QString pathApk = "C:/MASVS/" + nameProject + "/" + nameProject + ".apk";

    // когда начинается декомпиляция - запускаем окно ожидания в графике
    connect(console, SIGNAL(started()), this, SIGNAL(startDecompile()));

    // когда декомпиляция закончится - перейдём на другую страницу
    //connect(console, SIGNAL(finished(int, QProcess::ExitStatus)), console, SLOT(close()));
    connect(console, SIGNAL(finished(int,QProcess::ExitStatus)), this, SLOT(proc_finish()));

    // запускаем питоновский скрипт инструмента apkx для декомпиляции
    // папка создается автоматически, внутри прописала правильный путь по проекту
    console->start("C:\\Windows\\System32\\cmd.exe",
                   QStringList() << "/K" << "c: && cd C:/MASVS/ && apkx.py " + pathApk + " " + pathProject);

}

void SelectProject::proc_finish(){
    QByteArray byte = console->readAllStandardOutput();
    qDebug() << byte;  // Просто вывести результат

    // Здесь будем проверять, успешно ли прошла распаковка, если выход нормальный, то код равен 0
    int output = console->exitCode();

    if (output == 0){
        emit endDecompile();
    }
    else{
        emit errorDecompile();
    }
}

void SelectProject::downloadSource(QString apk, QString apk_dir, QString src){
    // Удаляем ненужные символы из пути к файлу, которые прислала графика
    apk.remove("file:///");

    // Записываем в конфигурационный файл с именем «название_проекта.conf»
    QFile file_conf("C:/MASVS/" + nameProject + "/" + nameProject + ".conf");
    file_conf.open(QIODevice::ReadWrite | QIODevice::Text);
              //| QIODevice::Append );
    QTextStream stream(&file_conf);
    stream.setCodec("UTF-8");

    // Записываем в файл проекта, какой стиль входных данных был выбран
    // Если ранее стоял другой тип, значит перезаписываем это значение на текущее
    QString type_input = "APK + Исходный код";


    // Затем записываем в конфиг проекта, какой файл apk мы взяли для анализа, чтобы имя потом не потерялось
    // Для этого проверяем, не стояло ли там уже какое-либо значение,
    // если строка заполнена, то удаляем её содержимое и пишем новое
    QString str;
    while(!stream.atEnd()){
        QString line = stream.readLine();
        if(line.contains("Input data: ") || line.contains("APK path: ")){
            qDebug() << "Перезаписываем следующие значения в конфиге проекта: " << line;
        }
        else{
            str.append(line + "\n");
        }
    }

    file_conf.resize(0);
    stream << str;
    stream << "Input data: " << type_input << endl; // записываем тип входных данных в конфиг файла
    stream << "APK path: " << apk << endl;          // записываем новый путь к файлу apk в конец конфига проекта
    file_conf.close();

    // Проверяем, что в каталоге не лежит никаких лишних файлов, помимо основного файла проекта,
    // если такие есть, то удаляем их, потому что они относятся к старому выбору пользователя
    QString path = "C:/MASVS/" + nameProject;
    QString conf = nameProject + ".conf";
    QDir dir(path);

    QStringList	listProject = dir.entryList(QDir::Files);

    for (int i = 0;  i < listProject.size(); i++){
        if(listProject[i] != conf){                         // если это не главный файл проекта
            QFile::remove(path + "/" + listProject[i]);     // то удаляем его
        }
    }

    // Затем копируем выбранный файл apk внутрь нашего проекта
    // Переименовываем для простоты использования в «название_проекта.apk»
    QString  file_apk = "C:/MASVS/" + nameProject + "/" + nameProject + ".apk";
    QFile::copy(apk, file_apk);

    // Далее копируем каталоги apk и src, задаем новые пути
    QString  pathNewDirApk = "C:/MASVS/" + nameProject + "/" + nameProject + "_apk";
    QString  pathNewDirSrc = "C:/MASVS/" + nameProject + "/" + nameProject + "_src";

    apk_dir.remove("file:///");
    src.remove("file:///");

    qDebug() << "Директория с файлами: " << apk_dir;
    copyDirectoryFiles(apk_dir, pathNewDirApk);
    copyDirectoryFiles(src, pathNewDirSrc);

    // посылаем сигнал в графику, что всё успешно скопировали
    emit downloadedSource();

    // этот сигнал нужен, чтобы страничка с уровнями понимала, куда ей "вернуться"
    emit selectLevel("source");

}


void SelectProject::copyDirectoryFiles(QString src, QString dst){
    QDir dir(src);
    if (! dir.exists()){
        return;
    }

    foreach (QString d, dir.entryList(QDir::Dirs | QDir::NoDotAndDotDot)) {
        QString dst_path = dst + QDir::separator() + d;
        dir.mkpath(dst_path);
        copyDirectoryFiles(src+ QDir::separator() + d, dst_path);
    }

    foreach (QString f, dir.entryList(QDir::Files)) {
        QFile::copy(src + QDir::separator() + f, dst + QDir::separator() + f);
    }

}

void SelectProject::writeLevel(QString level){
    // Записываем в файл конфигурации, по какому уровню будем проверять приложение
    QString path("C:/MASVS/" + nameProject);
    QFile file_conf(path + "/" + nameProject + ".conf");
    file_conf.open(QIODevice::WriteOnly | QIODevice::Text
              | QIODevice::Append );
    QTextStream stream(&file_conf);
    stream.setCodec("UTF-8");

    stream << "Security level: " << level << endl;    // записываем уровень безопасности

    file_conf.close();
}


void SelectProject::setListProject(){
    // сначала очищаем предыдущее содержимое модели,если она не пустая
    projects_model->clearR();

    QDir dir("C:/MASVS/");

    QStringList	listProject = dir.entryList(QDir::Dirs);

    qDebug() << listProject;

    listProject.removeAll(".");
    listProject.removeAll("..");

    qDebug() << listProject;

    for(int i = 0; i < listProject.size(); i++ ){
        // Проверяем, что у проекта есть отчёт, иначе не выводим его в список проектов
        QString report_file = "C:/MASVS/" + listProject[i] + "/" + listProject[i] + ".report";
        bool report_exists = QFile(report_file).exists();

        // подобные проекты необходимо удалять, они могут появится при незаконченном анализе приложения
        if (report_exists == false){
            qDebug() << "Неоконченный: " << listProject[i];
        }

        // выводим проект в качестве карточки в общий список
        else{
            qDebug() << "Отлично, выводим: " << listProject[i];
            readProject(listProject[i]);
        }
    }

    emit showProjects();     // показываем существующие проекты
}


void SelectProject::readProject(QString name){   
    // Присваиваем имя выбранного проекта глобальной переменной
    nameProject = name;

    // Считываем файл конфигурации данного проекта
    QString project_file = "C:/MASVS/" + name + "/" + name + ".conf";
    QFile file(project_file);

    file.open(QIODevice::ReadOnly);

    QStringList strList;

    while(!file.atEnd())
    {
        QString line = file.readLine();     // считываем новую строку
        line = line.trimmed();              // удаляем символы переноса строки \r\n
        strList.append(line);               // добавляем строку в список
    }

    QString create_date = strList[1].remove("Creation date: ");
    QString edit_date = strList[2].remove("Modified date: ");
    QString input_data = strList[3].remove("Input data: ");
    QString path_apk = strList[4].remove("APK path: ");
    QString level = strList[5].remove("Security level: ");
    QString percent = strList[6].remove("Percent: ");

    projects_model->addItem(ProjectObject(name, create_date, edit_date, input_data, path_apk, level, percent));

    file.close();
}

void SelectProject::checkPercent(QString name){
    // Открываем файл для считывания всех требований
    QString path("C:/MASVS/" + name);
    QFile file(path + "/" + name + ".report");
    file.open(QIODevice::ReadOnly);

    QStringList strList;

    int col = 0;  // количество требований
    int yesP = 0; // переменная для требований "ВЫПОЛНЕНО"
    int notP = 0; // переменная для требований "НЕ_ВЫПОЛНЕНО"
    int unknowP = 0; // переменная для требований "НЕИЗВЕСТНО"

    while(!file.atEnd())
    {
        QString line = file.readLine();

        if(line.contains("НЕ_ВЫПОЛНЕНО")){
            notP++;
        }
        else if(line.contains("НЕИЗВЕСТНО")){
            unknowP++;
        }
        else{
            yesP++;
        }
        col++;
    }

    file.close();

    int result = (yesP * 100) / col;
    qDebug() << "Yes: " << yesP << "No: " << notP << "Unknow: " << unknowP << "Result: " << result;

    // После этого записываем в файл конфигурации текущее значение соответствия
    QFile file_conf("C:/MASVS/" + name + "/" + name + ".conf");
    file_conf.open(QIODevice::ReadWrite | QIODevice::Text);
    QTextStream stream(&file_conf);
    stream.setCodec("UTF-8");

    // Записываем в файл проекта, сколько процентов соответствия у нас есть
    // Если ранее стояло другое значение, значит перезаписываем его на текущее
    QString str;
    while(!stream.atEnd()){
        QString line1 = stream.readLine();
        if(line1.contains("Percent: ")){
            qDebug() << "Перезаписываем следующие значения в конфиге проекта: " << line1;
        }
        else{
            str.append(line1 + "\n");
        }
    }

    file_conf.resize(0);
    stream << str;
    stream << "Percent: " <<  result << "%" << endl; // записываем проценты в конфиг файла
    file_conf.close();


    // Отправляем сигнал в qml, на страничку с выводом процентов и в список всех проектов
    emit sendPercent(name, col, yesP, notP, unknowP, result);
}

void SelectProject::showReport(QString name){
    // сначала очищаем предыдущее содержимое модели,если она не пустая
    reports_model->clearR();

    // а затем считываем построчно отчёт выбранного проекта, парсим и добавляем в модель
    qDebug() << "Вывожу отчёт по проекту: " << name;
    // Открываем файл для считывания всех требований
    QString path("C:/MASVS/" + name);
    QFile file(path + "/" + name + ".report");
    file.open(QIODevice::ReadOnly);

    QStringList strList;

    int a = 0;
    while(!file.atEnd())
    {
        strList << file.readLine();

        QString one_str = strList[a];

        int x = 0;
        int y = 0;

        QString Str1 = "***NUMBER: ";
        x = one_str.indexOf(Str1);
        x += Str1.length();
        y = one_str.indexOf(" ***DESCRIPTION:", x);
        QString number = one_str.mid(x, y-x);

        qDebug() << number;

        QString Str2 = "***DESCRIPTION: ";
        x = one_str.indexOf(Str2);
        x += Str2.length();
        y = one_str.indexOf(" ***RESULT:", x);
        QString description = one_str.mid(x, y-x);

        qDebug() << description;

        QString Str3 = "***RESULT: ";
        x = one_str.indexOf(Str3);
        x += Str3.length();
        y = one_str.indexOf(" ***FUNCTION:", x);
        QString result = one_str.mid(x, y-x);

        QString Str4 = "***FUNCTION: ";
        x = one_str.indexOf(Str4);
        x += Str4.length();
        y = one_str.indexOf("\r\n", x);
        QString func = one_str.mid(x, y-x);

        // добавляем элемент в модель с отчётом по всем спискам требований
        reports_model->addItem(ReportObject(number, description, result, func));
        a++;
    }

    file.close();

    emit sendName(name);    // отправляем сигнал  для заголовка в отчёте
    emit readReport();      // отображаем отчёт по конкретному проекту
}


void SelectProject::changeRes(QString nameProd, QString numberReq, QString nameReq, QString resultReq){
    // перезаписываем строку
    //Записываем данные в файл отчёта
    QFile file("C:/MASVS/" + nameProd + "/" + nameProd + ".report");
    file.open(QIODevice::ReadWrite | QIODevice::Text);

    QTextStream str_file(&file);
    str_file.setCodec("UTF-8");

    QString function = "Пользователь";

    QString str;
    while(!str_file.atEnd()){
        QString line = str_file.readLine();
        if(line.contains("***NUMBER: " + numberReq + " ***DESCRIPTION: ")){
            str.append("***NUMBER: " + numberReq + " ***DESCRIPTION: " + nameReq + " ***RESULT: " + resultReq + " ***FUNCTION: " + function + "\n");
        }
        else{
            str.append(line + "\n");
        }
    }

    file.resize(0);
    str_file << str;
    file.close();

    // пересматриваем модель
    showReport(nameProd);

}

void SelectProject::changeResult(QString nameProd, QString numberReq, QString resultReq){
    qDebug() << "Открыли карточку для изменения результата";
    qDebug() << "Сейчас покажу карточку с требованием для: " << nameProd << numberReq << resultReq;

    QStringList numbersL1 = {"1.1", "1.2", "1.3", "1.4", "1.12", "2.1", "2.4", "3.3", "3.5", "4.2", "4.3", "4.4",
                             "4.6", "4.8", "4.12", "5.2", "6.2", "6.4", "6.7", "6.8", "7.7", "7.8"};
    QStringList descriptionsL1 = {"Все компоненты приложения идентифицированы и используются",
                                  "Проверки безопасности реализованы не только на клиенте, но и на бэкенде",
                                  "Архитектура мобильного приложения учитывает все удалённые сервисы. Безопасность заложена в архитектуре",
                                  "Определены данные, которые являются чувствительными в контексте мобильного приложения",
                                  "Приложение должно соответствовать законам о защите персональных данных",
                                  "Хранилище учетных данных системы должно использоваться надлежащим образом для хранения чувствительных данных, таких как персональные данные, данные пользователя для авторизации и криптографические ключи",
                                  "Никакие чувствительные данные не передаются третьей стороне, если это не является необходимой частью архитектуры",
                                  "Приложение использует подходящие криптографические алгоритмы для каждого конкретного случая, с параметрами, которые соответствуют лучшим практикам индустрии",
                                  "Приложение не использует один и тот же ключ несколько раз",
                                  "Если используются сессии, бекэнд случайно генерирует идентификаторы сессии для аутентификации клиентских запросов без отправки данных учётной записи",
                                  "Если используется аутентификация на основе токена, сервер предоставляет токен, подписанный с использованием безопасного криптоалгоритма",
                                  "Бэкенд удаляет существующую сессию, когда пользователь выходит из системы",
                                  "На сервере реализован механизм защиты от перебора авторизационных данных",
                                  "Сессии становятся невалидными на бэкенде после определенного периода бездействия, срок действия токена истекает",
                                  "Модели авторизации должны быть определены и проверены на сервере",
                                  "Настройки TLS соответствуют современным лучшим практикам, или максимально приближены к ним, если операционная система не поддерживает рекомендуемые стандарты",
                                  "Все данные, поступающие из внешних источников и от пользователя, валидируются и санитизируются. Сюда входят данные, полученные через пользовательский интерфейс, механизмы IPC (такие как intent-ы, кастомные URL-схемы) и из сети",
                                  "Приложение не экспортирует чувствительные данные через IPC механизмы без должной защиты",
                                  "Если нативные методы приложения используются WebView, то необходимо верифицировать, что исполняются только Javascript объекты данного приложения",
                                  "Десериализация объектов, если она есть, реализована с использованием безопасного API",
                                  "В логике обработки ошибок, связанных с безопасностью, по умолчанию доступ запрещается",
                                  "В неконтролируемом коде память выделяется, освобождается и используется безопасно"};

    QStringList numbersL2 = {"1.5", "1.6", "1.7", "1.8", "1.10", "1.11", "2.10", "2.12", "2.13", "2.14", "2.15",
                             "4.7", "4.9", "4.10", "4.11", "5.4", "5.5", "6.10", "6.11"};
    QStringList descriptionsL2 = {"Все компоненты приложения определены с точки зрения бизнес логики и/или безопасности",
                                  "Сформирована модель угроз для мобильного приложения и связанных с ним удаленных сервисов, которая идентифицирует потенциальные угрозы и необходимые контрмеры",
                                  "Все проверки безопасности имеют централизованную реализацию",
                                  "Существует явная политика управления криптографическими ключами (если они есть) и их жизненным циклом. В идеале политика соответствует стандарту управления ключами, например, NIST SP 800-57",
                                  "Безопасность заложена во все этапы жизненного цикла разработки программного обеспечения",
                                  "Существует и эффективно применяется ответственная политика раскрытия информации",
                                  "Приложение не хранит чувствительные данные в памяти дольше, чем необходимо, и полностью удаляет их из памяти после работы с ними",
                                  "Приложение информирует пользователя о персональных данных, которые оно обрабатывает, а также о лучших практиках безопасности, которым должен следовать пользователь при использовании приложения",
                                  "Конфиденциальные данные локально не должны храниться на мобильном устройстве. Вместо этого необходимые данные должны получаться с сервера и храниться только в памяти",
                                  "Если конфиденциальные данные все же требуется хранить локально, они должны быть зашифрованы с помощью ключа, полученного из аппаратного хранилища, которое требует проверки подлинности",
                                  "Локальное хранилище приложения должно быть стерто после превышения допустимого количества неудачных попыток",
                                  "Биометрическая аутентификация не является event-bound (т.е. использует только API, которое возвращает «true» или «false»). Вместо этого она основана на разблокировке keychain/keystore",
                                  "Реализована и поддерживается двухфакторная аутентификация",
                                  "Для выполнения чувствительных транзакций требуется дополнительная или повторная аутентификация",
                                  "Приложение информирует пользователя о всех важных действиях с его учетной записью. Пользователи могут просматривать список устройств, контекстную информацию (IP-адрес, местоположение и т.д.), и блокировать конкретные устройства",
                                  "В приложении реализован SSL pinning и соединение с серверами, которые предлагают другой сертификат или ключ, даже если они подписаны доверенным центром сертификации (CA) не устанавливается",
                                  "Приложение не полагается на единственный небезопасный канал связи (e-mail или SMS) для таких критических операций, как регистрация и восстановление аккаунта",
                                  "Кэш веб-представления, хранилище и загруженные ресурсы (JavaScript и т. д.) должны быть очищены до того, как веб-представление будет уничтожено",
                                  "Убедитесь, что приложение предотвращает использование пользовательских клавиатур сторонних производителей при вводе конфиденциальных данных (только для iOS)"};

    QStringList numbersR = {"8.1", "8.2", "8.3", "8.4", "8.5", "8.6", "8.7", "8.8", "8.9", "8.10", "8.11", "8.12", "8.13"};
    QStringList descriptionsR = {"Приложение обнаруживает и реагирует на наличие root или jailbreak, уведомляя пользователя, либо прекращая работу",
                                 "Приложение не позволяет использовать отладчики и/или обнаруживает и реагирует на использование отладчика. Все доступные протоколы отладки должны быть учтены",
                                 "Приложение обнаруживает и реагирует на внесения изменений в исполняемые файлы и критичные данные в своей песочнице",
                                 "Приложение обнаруживает и реагирует на наличие на устройстве широко используемых инструментов и фреймворков для реверс инжиниринга",
                                 "Приложение обнаруживает и реагирует на запуск на эмуляторе",
                                 "Приложение обнаруживает и реагирует на изменение своего кода и данных в оперативной памяти",
                                 "Приложение реализует несколько механизмов для каждой категории защиты (с 8.1 по 8.6). Обратите внимание, что на устойчивость к атакам влияет количество, разнообразие и оригинальность используемых механизмов",
                                 "Механизмы обнаружения инициируют ответные меры разных типов, включая отложенные и скрытые",
                                 "Обфускация применена в том числе и к тем программным механизмам, которые препятствуют деобфускации методами динамического анализа",
                                 "Приложение реализует функциональность привязки экземпляра приложения к устройству, формируя его отпечаток из нескольких свойств, уникальных для устройства",
                                 "Все исполняемые файлы и библиотеки, принадлежащие приложению, зашифрованы на файловом уровне, либо важные участки кода и данных зашифрованы внутри исполняемых файлов. Простой статический анализ не позволяет обнаружить важный код или данные",
                                 "Если задачей обфускации является защита конфиденциальных данных, то используется схема обфускации, которая подходит не только для этой задачи, но и защищает от ручного тестирования и автоматизированных деобфускаторов и учитывает последние исследования по данной теме",
                                 "В качестве глубокой защиты, наряду с существенным усилением защиты взаимодействия, шифрование обмениваемых приложением сообщений может шифроваться для дальнейшего предотвращения перехвата"};

    QString nameReq;
    if(numbersL1.contains(numberReq)){
       int num = numbersL1.indexOf(numberReq);
       nameReq = descriptionsL1[num];
    }
    else if(numbersL2.contains(numberReq)){
       int num = numbersL2.indexOf(numberReq);
       nameReq = descriptionsL2[num];
    }
    else if(numbersR.contains(numberReq)){
       int num = numbersR.indexOf(numberReq);
       nameReq = descriptionsR[num];
    }

    emit showOneTest(nameProd, numberReq, nameReq, resultReq);
}
