#include "selectproject.h"

#include <QDateTime>
#include <QFile>
#include <QDir>

QString nameProject;


SelectProject::SelectProject(QObject *QMLObject) : viewer(QMLObject)
{
    projects_model = new ProjectsModel();       // модель для существующих проектов
    reports_model = new ReportsModel();         // модель для отчёта по проекту

}


void SelectProject::checkNameProject(QString name){
    // Проверяем, соответсвует ли данное название правилам ФС
    // Тут пойдёт проверка и сигнал в QML, если не подходит типо
    // emit errorName(name) и завершаем функцию

    //************************НЕРЕАЛИЗОВАННОЕ********************************************//



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

    /*
    // если декомпилироваться будет долго, то можно будет это реализовать, а пока не нужно
    // присваиваем полученное значение глобальной переменной
    new_apk = apk;
    qDebug() << "Выбранный файл apk: " << apk;
    qDebug() << "Новый файл apk: " << new_apk;
    qDebug() << "Старый старый файл apk: " << old_apk;

    // если декомпилироваться будет долго, то можно будет это реализовать, а пока не нужно
    // Если файл в целевой директории уже существует,то сначала удаляем его:
    if (QFile::exists("/path/copy-of-file")){
    QFile::remove("/path/copy-of-file");
    }*/


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

    // перед концом объявляем, что этот файл будет "старым", если пользователь передумает с выбором
    //old_apk = new_apk;
    //qDebug() << "Новый старый файл apk: " << old_apk;

    // если файл успешно декомпилирован, то оповещаем графику, что мы успешно загрузили apk и можно продолжить
    connect(this, SIGNAL(endDecompile()), this, SIGNAL(downloadedApk()));

    // в случае неудачи декомпиляции оповещаем графику, что с файлом проблемы, нужно его изменить
    connect(this, SIGNAL(errorDecompile()), this, SIGNAL(errorApk()));

    // этот сигнал нужен, чтобы страничка с уровнями понимала, куда ей "вернуться"
    emit selectLevel("apk");
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

    // Далее сделать копирование других выбранных каталогов!!!!!!!!!
    // пока никак, потому что неправильные у меня диалоги



    /*************************************************/
    // эта проверка не нужна, она уже реализована в графике
    // здесь будем конкретно проверять наличие манифеста и исходников
    if ((apk != "") && (apk_dir != "") && (src != "")){
        // оповещаем графику, что мы успешно загрузили файл apk с исходниками
        emit downloadedSource();
    }

    /*******************************************/
    // ПЕРЕДЕЛАТЬ

    // Этот сигнал будет передаваться в нескольких местах, чтобы подавать разные ошибки!!!!
    else{
        QString error = "Например, Вы не загрузили манифест, пожалуйста, измените данные во втором окне";
        emit errorSource(error);

    }

    // этот сигнал нужен, чтобы страничка с уровнями понимала, куда ей "вернуться"
    emit selectLevel("source");

}

void SelectProject::decompileApk(){
    emit startDecompile();  // этот сигнал отправляем в графику

    // Здесь будем проверять, успешно ли прошла распаковка.
    // Потом удалить
    bool sucess_decompile = true;
    if (sucess_decompile == true){
        // потом убрать таймер, хотя, если будет грузится быстро, то можно и оставить
        // сигнал отправляем не графику, а сюда же в класс, в функцию выше
        QTimer::singleShot(5000, this, SIGNAL(endDecompile()));
    }

    else{
        // потом убрать таймер, хотя, если будет грузится быстро, то можно и оставить
        // сигнал отправляем не графику, а сюда же в класс, в функцию выше
        QTimer::singleShot(5000, this, SIGNAL(errorDecompile()));
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

