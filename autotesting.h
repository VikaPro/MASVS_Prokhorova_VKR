#ifndef AUTOTESTING_H
#define AUTOTESTING_H

#include "selectproject.h"
#include "permissionmodel.h"

#include <QObject>
#include <QDebug>
#include <QFile>
#include <QAbstractItemModel>

extern QString levelProject; // глобальная переменная для уровня безопасности текущего проекта

class AutoTesting : public QObject
{
    Q_OBJECT

public:
    explicit AutoTesting(QObject *parent = nullptr);

    PermissionModel * permission_model;

    QString number;
    QString description;
    QString result;
    QString func;

    //QFile file;
    //QTextStream str_file;

public slots:

    // Запускаем автоматические тесты для анализа безопасности приложения
    void autoTest(QString level);

    void writeReportAuto(QString number, QString description, QString result, QString func);

    // функция для рекурсивного поиска файлов в каталоге
    QStringList readDir(QString nameDir);

    // функция для поиска файла манифеста для текущего проекта
    QString findManifest();

    // функция задержки отправки сигналов о завершении проверки
    void emitLater(const char *signalOrSlot);

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
    // дополнительная функци для 6.1, т.к. здесь вмешивается пользователь
    void resultMinPermissions(QString result);

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
    void endOneTest(QString number, QString description, QString result, QString func);
    // сообщаем программе, что все автоматизированные тесты пройдены
    void endAutoTest();
    // сообщаем программе, сколько будет автотестов для progressbar
    void colAutoTest(int col);
    // сообщаем программе, что автоматические проверки для 1 уровня завершены
    void endAutoLevel1();
    // сообщаем программе, что автоматические проверки для 2 уровня завершены
    void endAutoLevel2();
    // Отображаем в графику полученные разрешения для требования 6.1
    void checkPermission();

    // Сигналы, необходимые для последовательного выполнения тестов
    // Сигналы для 1 уровня

    void endData2CheckInternal();
    void endData3CheckLog();
    void endData5KeyboardCache();
    void endData6CheckIPC();
    void endData7CheckInterface();

    void endCrypto1Symmetrical();
    void endCrypto2ProvenAlgorithms();
    void endCrypto4WeakAlgorithms();
    void endCrypto6RandomGenerator();

    void endAuth1LoginPass();
    void endAuth5PassPolicy();

    void endNet1CryptoTLS();
    void endNet3VerifiesX509();

    void endOs1MinPermissions();
    void endOs3CustomURL();
    void endOs5DisabledJava();
    void endOs6OnlyHTTPS();

    void endCode1ValidCert();
    void endCode2BuildRelease();
    void endCode3DebugSymbols();
    void endCode4DeveloperCode();
    void endCode5ThirdPartyLib();
    void endCode6ExceptionHandling();
    //void endCode9SecurityTools();

    // Сигналы для 2 уровня

    void endArch9CheckUpdate();

    void endData8CheckBackup();
    void endData9BackgroundMode();
    void endData11InstallPincode();

    void endNet6CheckLibrary();

    //void endOs9ScreenOverlay();


protected:
    QObject *viewer;  // связь функций C++ с qml-страничками

};

#endif // AUTOTESTING_H
