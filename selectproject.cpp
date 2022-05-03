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
    QFile file(path + "/" + name + "_qt.txt");
    file.open(QIODevice::WriteOnly | QIODevice::Text
              | QIODevice::Append );
    QTextStream a(&file);
    a.setCodec("UTF-8");
    a << name << endl;      // записываем название проекта
    a << dateStr << endl;   // записываем дату создания
    a << dateStr << endl;   // записываем дату изменения, которая на момент создания совпадает с верхней

    file.close();

    nameProject = name;     // присваиваем глобальной переменной название текущего проекта
}

void SelectProject::downloadApk(){
    QString typeFile = "apk";
    qDebug() << "Загрузка файла";
    emit selectLevel(typeFile);
}

void SelectProject::downloadSource(){
    emit downloadedSource();    // оповещаем графику, что мы загрузили файл apk с исходниками
    QString typeFile = "source";
    qDebug() << "Загрузка исходников";
    emit selectLevel(typeFile);
}

void SelectProject::decompileApk(){
    emit downloadedApk();       // оповещаем графику, что мы загрузили только файл apk

    // потом убрать
    QTimer::singleShot(5000, this, SLOT(endTimer()));

    //emit endDecompile();
}

void SelectProject::endTimer(){
    emit endDecompile();
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


//void SelectProject::downloadFile(){
    //emit selectLevel();         // после загрузки файлов можно выбирать уровень безопасности
//}

