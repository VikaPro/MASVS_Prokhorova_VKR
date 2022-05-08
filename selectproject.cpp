#include "selectproject.h"

#include <QDateTime>
#include <QFile>
#include <QDir>

QString nameProject;

SelectProject::SelectProject(QObject *QMLObject) : viewer(QMLObject)
{
    projects_model = new ProjectsModel();       // модель для существующих проектов
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
    QFile file_conf(path + "/" + name + "_qt.txt");
    file_conf.open(QIODevice::WriteOnly | QIODevice::Text
              | QIODevice::Append );
    QTextStream str(&file_conf);
    str.setCodec("UTF-8");

    str << "Project name: " << name << endl;      // записываем название проекта
    str << "Creation date: " << dateStr << endl;   // записываем дату создания
    str << "Modified date: " << dateStr << endl;   // записываем дату изменения, которая на момент создания совпадает с верхней

    file_conf.close();

    nameProject = name;     // присваиваем глобальной переменной название текущего проекта
}

void SelectProject::downloadApk(QString apk){
    // Удаляем ненужные символы из пути к файлу, которые прислала графика
    apk.remove("file:///");


    QFile file_conf("C:/MASVS/" + nameProject + "/" + nameProject + "_qt.txt");
    file_conf.open(QIODevice::ReadWrite | QIODevice::Text);
              //| QIODevice::Append );
    QTextStream stream(&file_conf);
    stream.setCodec("UTF-8");

    // Записываем в файл проекта, какой стиль входных данных был выбран
    // Если ранее стоял другой тип, значит перезаписываем это значение на текущее
    QString type_input = "Только APK";

    // Затем записываем в конфиг проекта, какой файл apk мы взяли для анализа, чтобы имя не потерялось потом
    // Для этого проверяем, не стояло ли там уже какое-либо значение,
    // если строка заполнена, то удаляем её содержимое и пишем новое
    QString str;
    while(!stream.atEnd()){
        QString line = stream.readLine();
        if(line.contains("Input data: ") || line.contains("APK path: ")){
            qDebug() << "Перезаписываем следующие значения в проекте" << line;
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
    QString conf = nameProject + "_qt.txt";
    QDir dir(path);

    QStringList	listProject = dir.entryList(QDir::Files);

    for (int i = 0;  i < listProject.size(); i++){
        if(listProject[i] != conf){                         // если это не главный файл проекта
            QFile::remove(path + "/" + listProject[i]);     // то удаляем его
        }
    }

    // Затем копируем выбранный файл apk внутрь нашего проекта
    // Переименовываем для простоты использования
    QString  file_apk = "C:/MASVS/" + nameProject + "/" + nameProject + "_apk.apk";
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

void SelectProject::downloadSource(){

    // оповещаем графику, что мы успешно загрузили файл apk с исходниками
    emit downloadedSource();

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


void SelectProject::setListProject(){ 

    QDir dir("C:/MASVS/");

    QStringList	listProject = dir.entryList(QDir::Dirs);

    qDebug() << listProject;

    listProject.removeAll(".");
    listProject.removeAll("..");

    qDebug() << listProject;

    for(int i = 0; i < listProject.size(); i++ ){
        // Проверяем, что у проекта есть отчёт, иначе не выводим его в список проектов
        QString report_file = "C:/MASVS/" + listProject[i] + "/" + listProject[i] + "_report.txt";
        bool report_exists = QFile(report_file).exists();

        // подобные проекты необходимо удалять, они могут появится при незаконченном анализе приложения
        if (report_exists == false){
            qDebug() << "Неоконченный: " << listProject[i];
        }

        // выводим проект в качестве карточки в общий список
        else{
            qDebug() << "Круто, выводим: " << listProject[i];
            readProject(listProject[i]);
        }
    }

    emit showProjects();     // показываем существующие проекты
}


void SelectProject::readProject(QString name){
    QString project_file = "C:/MASVS/" + name + "/" + name + "_qt.txt";
    QFile file(project_file);

    file.open(QIODevice::ReadOnly);
    QTextStream log(&file);
    log.setCodec("UTF-8");

    QStringList strList;

    while(!file.atEnd())
    {
        QString line = file.readLine();     // считываем новую строку
        line = line.trimmed();              // удаляем символы переноса строки \r\n
        strList.append(line);               // добавляем строку в список
    }

    QString create_date = strList[1];

    QString edit_date = strList[2];

    projects_model->addItem(ProjectObject(name, create_date, edit_date));

    file.close();

}

void SelectProject::showReport(QString name){
    qDebug() << "Вывожу отчёт по проекту: " << name;
    emit readReport();     // отображаем отчёт по конкретному проекту
}

