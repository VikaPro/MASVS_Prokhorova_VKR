#ifndef SELECTPROJECT_H
#define SELECTPROJECT_H

#include <QObject>
#include <QDebug>

class SelectProject : public QObject
{
    Q_OBJECT

public:
    explicit SelectProject(QObject *parent = nullptr);

public slots:
    // Загружаем файл Apk
    void downloadApk();
    // Загружаем файл Apk совместно с исходным кодом
    void downloadSource();
    // Подтверждаем загрузку файлов
    //void downloadFile();
    void decompileApk();


signals:
    // оповещаем графику, что файл Apk успешно загружен
    void downloadedApk();
    // оповещаем графику, что файл Apk совместно с исходным кодом успешно загружены
    void downloadedSource();
    // вызываем выбор уровня безопасности после загрузки файлов
    void selectLevel(QString typeFile);

    void endDecompile();



protected:
    QObject *viewer;  // связь функций C++ с qml-страничками

};


#endif // SELECTPROJECT_H
