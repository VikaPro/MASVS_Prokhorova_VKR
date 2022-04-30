#include "selectproject.h"

#include <QDateTime>

SelectProject::SelectProject(QObject *QMLObject) : viewer(QMLObject)
{

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
    QTime now;
    QString timeStr;
    while (true){
        now = QTime::currentTime();
        timeStr = now.toString();
        if (timeStr == "21:55:00"){
            break;
        }
    }
    qDebug() << "Я всё!!!";
    emit endDecompile();

}

//void SelectProject::downloadFile(){
    //emit selectLevel();         // после загрузки файлов можно выбирать уровень безопасности
//}


