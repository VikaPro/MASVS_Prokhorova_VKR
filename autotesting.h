#ifndef AUTOTESTING_H
#define AUTOTESTING_H

#include "selectproject.h"

#include <QObject>
#include <QDebug>

class AutoTesting : public QObject
{
    Q_OBJECT

public:
    explicit AutoTesting(QObject *parent = nullptr);

    QString number;
    QString description;
    QString result;

public slots:

    // Запускаем автоматические тесты для анализа безопасности приложения
    void autoTest(QString level);


    // Все эти функции потом будут вынесены в другой файл
    void autoTestLevel1();
    void autoTestLevel2();

    // удалить, костыльная функция для таймера
    void deleteFun();

    // можно потом удалить, если найду другое решение
    //void allEndAutoTest();

    // требования для уровня L1
    void data2CheckInternal();
    void data3CheckLog();
    void data5KeyboardCache();
    void data6CheckIPC();
    void data7CheckInterface();

    void crypto1Symmetrical();
    void crypto2ProvenAlgorithms();
    void crypto4WeakAlgorithms();
    void crypto6RandomGenerator();

    void auth1LoginPass();
    void auth5PassPolicy();

    void net1CryptoTLS();
    void net3VerifiesX509();

    void os1MinPermissions();
    void os3CustomURL();
    void os5DisabledJava();
    void os6OnlyHTTPS();

    void code1ValidCert();
    void code2BuildRelease();
    void code3DebugSymbols();
    void code4DeveloperCode();
    void code5ThirdPartyLib();
    void code6ExceptionHandling();
    void code9SecurityTools();


    // требования для уровня L2
    void arch9CheckUpdate();

    void data8CheckBackup();
    void data9BackgroundMode();
    void data11InstallPincode();

    void net6CheckLibrary();

    void os9ScreenOverlay();


signals:
    // сообщаем программе, что конкретный тест завершен
    void endOneTest(QString number, QString description, QString result);
    // сообщаем программе, что все автоматизированные тесты пройдены
    void endAutoTest();
    // сообщаем программе, сколько будет автотестов для progressbar
    void colAutoTest(int col);
    // сообщаем программе, что автоматические проверки для 1 уровня завершены
    //void endAutoLevel1();
    // сообщаем программе, что автоматические проверки для 2 уровня завершены
    //void endAutoLevel2();


protected:
    QObject *viewer;  // связь функций C++ с qml-страничками

};

#endif // AUTOTESTING_H
