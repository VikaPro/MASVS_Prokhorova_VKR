#ifndef USERTESTING_H
#define USERTESTING_H

#include <QObject>
#include <QDebug>
#include <QFile>

#include "autotesting.h"
#include "selectproject.h"
//#include "reportsmodel.h"


class UserTesting : public QObject
{
    Q_OBJECT

public:
    explicit UserTesting(SelectProject * p_select, QObject *parent = nullptr);

    QStringList numbers;
    QStringList descriptions;
    //QString result;

    SelectProject * select = nullptr;

    // удалить
    //ReportsModel * reports_model;

public slots:

    // Запускаем пользовательские (ручные) "тесты" для анализа безопасности приложения
    void userTest();

    // Данная функция уже знает, какие именно списки требования мы проверяем
    void oneCard(int index);

    // Пока просто выводим результат, но скорее всего тут будет запись в файл
    // перекомментировать
    void resultUser(QString number, QString description, QString result, int index);

    // Функция, которая запишет в отчёт оставшиеся проверки, если пользователь захочет прекратить
    void incompleteChecks(int index);

    // Перед просмотром отчёта - сортируем файл по порядку возрастания
    void sortReport();


signals:
    // по сигналу выводим карточку с новым требованием на экран
    void showUserCard(QString number, QString description, int index);
    // сообщаем программе, сколько будет ручных тестов для progressbar
    void colUserTest(int col);
    // сообщаем программе, что все проверки закончены, отчёт сформирован - можно отображать
    void allTestEnd();


protected:
    QObject *viewer;  // связь функций C++ с qml-страничками

};

#endif // USERTESTING_H
