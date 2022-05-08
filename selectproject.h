#ifndef SELECTPROJECT_H
#define SELECTPROJECT_H

#include <QObject>
#include <QDebug>
#include <QTimer>

#include "projectsmodel.h"

extern QString nameProject; // глобальная переменная для названия текущего проекта

class SelectProject : public QObject
{
    Q_OBJECT

public:
    explicit SelectProject(QObject *parent = nullptr);

    ProjectsModel * projects_model;

    // Если декомпиляция будет долгой, то вернём этот метод
    // переменные необходимы для возможности удаления файлов из проекта
    // если пользователь передумает с выбором входных данных
    //QString new_apk;
    //QString old_apk;

public slots:
    // Проверяем, что проекта с таким именем не существует
    void checkNameProject(QString name);
    // Создаём файл с данными для нового проекта
    void nameNewProject(QString name);
    // Загружаем файл Apk
    void downloadApk(QString apk);
    // Загружаем файл Apk совместно с исходным кодом
    void downloadSource();
    // Декомпилируем файл APK, если у нас нет исходного кода
    void decompileApk();
    // Получаем список существующих проектов
    void setListProject();
    // Считываем информацию о существующем проекте из его файлов
    void readProject(QString name);
    // Выводим отчёт по существующему проекту
    void showReport(QString name);

signals:
    // просим пользователя изменить имя, т.к. проект с таким именем уже существует
    void projectExists(QString name);
    // даём согласие на создание проекта с введенным именем
    void newProject();
    // оповещаем графику, что файл Apk успешно загружен
    void downloadedApk();
    // оповещаем графику, что с декомпиляуией файла Apk возникли проблемы
    void errorApk();
    // оповещаем графику, что файл Apk совместно с исходным кодом успешно загружены
    void downloadedSource();
    // вызываем выбор уровня безопасности после загрузки файлов
    void selectLevel(QString typeFile);
    // сообщаем программе, что начали декомпиляцию apk и надо запустить загрузку
    void startDecompile();
    // сообщаем программе, что файл декомпилирован и можно переключить страницу
    void endDecompile();
    // сообщаем программе, что файл не декомпилирован и входные данные нужно поменять
    void errorDecompile();
    // сообщаем программе, что список с проектами готов и его можно отобразить
    void showProjects();
    // сообщаем программе, что отчёт по проекту успешно считан и его можно отобразить
    void readReport();

protected:
    QObject *viewer;  // связь функций C++ с qml-страничками

};


#endif // SELECTPROJECT_H
