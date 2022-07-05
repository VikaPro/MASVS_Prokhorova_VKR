#ifndef SELECTPROJECT_H
#define SELECTPROJECT_H

#include <QObject>
#include <QDebug>
#include <QTimer>
#include <QProcess>

#include "projectsmodel.h"
#include "reportsmodel.h"

extern QString nameProject; // глобальная переменная для названия текущего проекта


class SelectProject : public QObject
{
    Q_OBJECT

public:
    explicit SelectProject(QObject *parent = nullptr);

    ProjectsModel * projects_model;
    ReportsModel * reports_model;
    QProcess *console;


public slots:
    // Проверяем, что проекта с таким именем не существует
    void checkNameProject(QString name);
    // Создаём файл с данными для нового проекта
    void nameNewProject(QString name);
    // Загружаем файл Apk
    void downloadApk(QString apk);
    // Загружаем файл Apk совместно с исходным кодом
    void downloadSource(QString apk, QString apk_dir, QString src);
    // Декомпилируем файл APK, если у нас нет исходного кода
    void decompileApk();
    // Записываем, по какому уровню проверяем приложени
    void writeLevel(QString level);
    // Получаем список существующих проектов
    void setListProject();
    // Считываем информацию о существующем проекте из его файлов
    void readProject(QString name);
    // Сначала подсчитываем уровень соответсвия в процентах
    void checkPercent(QString name);
    // Выводим отчёт по существующему проекту
    void showReport(QString name);
    // перезаписываем значение требования в отчёт после изменения
    void changeRes(QString nameProd, QString numberReq, QString nameReq, QString resultReq);
    // Функция для изменения результата ручной проверки
    void changeResult(QString nameProd, QString numberReq, QString resultReq);
    // узнаем результат декомпиляции
    void proc_finish();    
    // функция рекурсовного копирования
    void copyDirectoryFiles(QString src, QString dst);

signals:
    // просим пользователя изменить имя, т.к. проект с таким именем уже существует
    void projectExists(QString name);
    // даём согласие на создание проекта с введенным именем
    void newProject();
    // оповещаем графику, что файл Apk успешно загружен
    void downloadedApk();
    // оповещаем графику, что с декомпиляуией файла Apk возникли проблемы
    void errorApk();
    // оповещаем графику, что в каталогах пользователя чего-то не хватает
    void errorSource(QString error);

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
    // в заголовке страницы с отчётом отображаем название проекта
    void sendName(QString name);
    void sendPercent(QString name, int col, int yesP, int notP, int unknowP, int result);
    // показываем пользователю то требование, которое он выбрал
    void showOneTest(QString nameProd, QString numberReq, QString nameReq, QString resultReq);



protected:
    QObject *viewer;  // связь функций C++ с qml-страничками

};


#endif // SELECTPROJECT_H
