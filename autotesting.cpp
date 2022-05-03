#include "autotesting.h"

#include <QTimer>
#include <QDateTime>
#include <QFile>
#include <QDir>
#include <QElapsedTimer>

#include <QQmlContext>

AutoTesting::AutoTesting(QObject *QMLObject) : viewer(QMLObject)
{

}

void AutoTesting::autoTest(QString level){        
    qDebug() << "Сейчас будут автотесты по уровню: " << level;

    if (level == "L1"){
        emit colAutoTest(24);
        autoTestLevel1();
    }

    else if (level == "L2"){
        emit colAutoTest(30);
        autoTestLevel1();
        autoTestLevel2();
    }

    else if (level == "L1R"){
        emit colAutoTest(24);
        autoTestLevel1();
    }

    else if (level == "L2R"){
        emit colAutoTest(30);
        autoTestLevel1();
        autoTestLevel2();
    }

    else{
        qDebug() << "Что-то пошло не так...";
    }


    qDebug() << "Скажу всем, что я уже всё сделал!!!";
    emit endAutoTest();

}

// потом все эти функции вынести в отдельный файл с созданием класса
void AutoTesting::autoTestLevel1(){
    qDebug() << "Я сейчас нахожусь в проверках 1 и тестирую: " << nameProject;

    // Файл, в котором будет храниться отчёт о тестировании
    QFile file("C:/MASVS/" + nameProject + "/" + nameProject + "_report.txt");
    file.open(QIODevice::WriteOnly | QIODevice::Text
              | QIODevice::Append );

    QTextStream str(&file);
    str.setCodec("UTF-8");

    // ВНУТРИ ЦИКЛА НУЖНО БУДЕТ СДЕЛАТЬ ТАЙМЕР!!!! ОБЫЧНЫЙ СПОСОБ НЕ РАБОТАЕТ!!!

    for(int i = 0; i < 24; i++){
        if (i == 0){
            data2CheckInternal();
            number = "2.2";
            description = "Чувствительные данные хранятся только во внутреннем хранилище приложения, либо в системном хранилище авторизационных данных";
        }

        else if (i == 1){
            data3CheckLog();
            number = "2.3";
            description = "Чувствительные данные не попадают в логи приложения";
        }

        else if (i == 2){
            data5KeyboardCache();
            number = "2.5";
            description = "Кэш клавиатуры выключен для полей ввода чувствительных данных";
        }

        else if (i == 3){
            data6CheckIPC();
            number = "2.6";
            description = "Чувствительные данные недоступны для механизмов межпроцессного взаимодействия (IPC)";
        }

        else if (i == 4){
            data7CheckInterface();
            number = "2.7";
            description = "Никакие чувствительные данные, такие как пароли или пин-коды, не видны через пользовательский интерфейс";
        }

        else if (i == 5){
            crypto1Symmetrical();
            number = "3.1";
            description = "Приложение не использует симметричное шифрование с жестко закодированными ключами в качестве единственного метода шифрования";
        }

        else if (i == 6){
            crypto2ProvenAlgorithms();
            number = "3.2";
            description = "Приложение использует проверенные реализации криптографических алгоритмов";
        }

        else if (i == 7){
            crypto4WeakAlgorithms();
            number = "3.4";
            description = "Приложение не использует устаревшие и слабые криптографические протоколы и алгоритмы";
        }

        else if (i == 8){
            crypto6RandomGenerator();
            number = "3.6";
            description = "Все случайные значения генерируются с использованием безопасного генератора случайных чисел";
        }

        else if (i == 9){
            auth1LoginPass();
            number = "4.1";
            description = "Если приложение предоставляет пользователям доступ к удалённым сервисам, на бэкенде должна быть реализована аутентификация, например, по логину и паролю";
        }

        else if (i == 10){
            auth5PassPolicy();
            number = "4.5";
            description = "На сервере реализована парольная политика";
        }

        else if (i == 11){
            net1CryptoTLS();
            number = "5.1";
            description = "Данные, передаваемые по сети, шифруются с использованием TLS. Безопасный канал используется для всех сервисов приложения";
        }

        else if (i == 12){
            net3VerifiesX509();
            number = "5.3";
            description = "Приложение верифицирует X.509 сертификаты сервера во время установления защищённого канала. Принимаются только сертификаты, подписанные доверенным удостоверяющим центром (CA)";
        }

        else if (i == 13){
            os1MinPermissions();
            number = "6.1";
            description = "Приложение запрашивает минимально необходимый набор разрешений";
        }

        else if (i == 14){
            os3CustomURL();
            number = "6.3";
            description = "Приложение не экспортирует чувствительные данные через кастомные URL-схемы, если эти механизмы не защищены должным образом";
        }

        else if (i == 15){
            os5DisabledJava();
            number = "6.5";
            description = "JavaScript отключен в компонентах WebView, если в нём нет необходимости";
        }

        else if (i == 16){
            os6OnlyHTTPS();
            number = "6.6";
            description = "WebViews сконфигурирован с поддержкой минимального набора протоколов (в идеале только https). Поддержка потенциально опасных URL-схем (таких как: file, tel и app-id) отключена";
        }

        else if (i == 17){
            code1ValidCert();
            number = "7.1";
            description = "Приложение подписано валидным сертификатом";
        }

        else if (i == 18){
            code2BuildRelease();
            number = "7.2";
            description = "Приложение было собрано в release режиме с настройками, подходящими для релизной сборки (например, без атрибута debuggable)";
        }

        else if (i == 19){
            code3DebugSymbols();
            number = "7.3";
            description = "Отладочные символы удалены из нативных бинарных файлов";
        }

        else if (i == 20){
            code4DeveloperCode();
            number = "7.4";
            description = "Kод отладки и вспомогательный для разработки код (например, тестовый код, бэкдоры, скрытые настройки) были удалены. Приложение не логирует подробные ошибки и отладочные сообщения";
        }

        else if (i == 21){
            code5ThirdPartyLib();
            number = "7.5";
            description = "Все сторонние компоненты, используемые мобильным приложением (библиотеки и фреймворки), идентифицированы и проверены на наличие известных уязвимостей";
        }
        else if (i == 22){
            code6ExceptionHandling();
            number = "7.6";
            description = "Приложение обрабатывает возможные исключения";
        }

        else if (i == 23){
            code9SecurityTools();
            number = "7.9";
            description = "Активированы все стандартные функции безопасности, предусмотренные инструментами разработчика (такие как минификация байт-кода, защита стека, поддержка PIE и ARC)";
        }

        qDebug() << "Требование №: " << number;
        qDebug() << "Описание: " << description;
        qDebug() << "Результат: " << result;

        emit endOneTest(number, description, result); // сигнал в графику
        str << "***NUMBER: " << number << " ***DESCRIPTION: " << description << " ***RESULT: " << result << endl;      // записываем результат теста в новую строку

        // после выполнения каждой функции делаем небольшую паузу, чтобы пользователь успел увидеть результат
        //QTimer::singleShot(3000, this, SLOT(deleteFun()));
        deleteFun();


    }

    file.close();


}

void AutoTesting::deleteFun(){
    qDebug() << "Жду 3 секунды, чтобы любимый пользователь успел увидеть результат!";
    /*QElapsedTimer et;
    et.start();
    while(true)
    {
      //qApp->processEvents();
      if(et.elapsed() > 5000) break;
    }*/

    QTimer* ptimer = new QTimer(this);
    for (int i = 0; i < 1; i++) {
        connect(ptimer, SIGNAL(timeout()), SLOT(break));
        ptimer->start(5000);
    }
}

void AutoTesting::autoTestLevel2(){
    qDebug() << "Я сейчас нахожусь в проверках 2 и тестирую: " << nameProject;

    // Файл, в котором будет храниться отчёт о тестировании
    QFile file("C:/MASVS/" + nameProject + "/" + nameProject + "_report.txt");
    file.open(QIODevice::WriteOnly | QIODevice::Text
              | QIODevice::Append );

    QTextStream str(&file);
    str.setCodec("UTF-8");

    // ВНУТРИ ЦИКЛА НУЖНО БУДЕТ СДЕЛАТЬ ТАЙМЕР!!!! ОБЫЧНЫЙ СПОСОБ НЕ РАБОТАЕТ!!!

    for(int i = 0; i < 6; i++){
        if (i == 0){
            arch9CheckUpdate();
            number = "1.9";
            description = "Существует механизм принудительных обновлений мобильного приложения";
        }

        else if (i == 1){
            data8CheckBackup();
            number = "2.8";
            description = "Никакие чувствительные данные не попадают в бэкапы, создаваемые операционной системой";
        }

        else if (i == 2){
            data9BackgroundMode();
            number = "2.9";
            description = "Приложение скрывает чувствительные данные с экрана, когда находится в фоновом режиме";
        }

        else if (i == 3){
            data11InstallPincode();
            number = "2.11";
            description = "Приложение требует от пользователя минимальную настройку доступа к устройству, такую, как установку пин-кода на устройство";
        }

        else if (i == 4){
            net6CheckLibrary();
            number = "5.6";
            description = "Приложение использует только актуальные версии библиотек для подключения к сети и обеспечения безопасного соединения";
        }

        else if (i == 5){
            os9ScreenOverlay();
            number = "6.9";
            description = "Приложение защищает себя от атак наложения экрана";
        }

        qDebug() << "Требование №: " << number;
        qDebug() << "Описание: " << description;
        qDebug() << "Результат: " << result;

        emit endOneTest(number, description, result); // сигнал в графику
        str << "***NUMBER: " << number << " ***DESCRIPTION: " << description << " ***RESULT: " << result << endl;      // записываем результат теста в новую строку
    }

    file.close();

}

// Требование 2.2
void AutoTesting::data2CheckInternal(){
    result = "ВЫПОЛНЕНО";
}

// Требование 2.3
void AutoTesting::data3CheckLog(){
    result = "НЕ ВЫПОЛНЕНО";
}

// Требование 2.5
void AutoTesting::data5KeyboardCache(){
    result = "ВЫПОЛНЕНО";
}

// Требование 2.6
void AutoTesting::data6CheckIPC(){
    result = "ВЫПОЛНЕНО";
}

// Требование 2.7
void AutoTesting::data7CheckInterface(){
    result = "ВЫПОЛНЕНО";
}

// Требование 3.1
void AutoTesting::crypto1Symmetrical(){
    result = "ВЫПОЛНЕНО";
}

// Требование 3.2
void AutoTesting::crypto2ProvenAlgorithms(){
    result = "ВЫПОЛНЕНО";
}

// Требование 3.4
void AutoTesting::crypto4WeakAlgorithms(){
    result = "ВЫПОЛНЕНО";
}

// Требование 3.6
void AutoTesting::crypto6RandomGenerator(){
    result = "ВЫПОЛНЕНО";
}

// Требование 4.1
void AutoTesting::auth1LoginPass(){
    result = "ВЫПОЛНЕНО";
}

// Требование 4.5
void AutoTesting::auth5PassPolicy(){
    result = "ВЫПОЛНЕНО";
}

// Требование 5.1
void AutoTesting::net1CryptoTLS(){
    result = "ВЫПОЛНЕНО";
}

// Требование 5.3
void AutoTesting::net3VerifiesX509(){
    result = "ВЫПОЛНЕНО";
}

// Требование 6.1
void AutoTesting::os1MinPermissions(){
    result = "ВЫПОЛНЕНО";
}

// Требование 6.3
void AutoTesting::os3CustomURL(){
    result = "ВЫПОЛНЕНО";
}

// Требование 6.5
void AutoTesting::os5DisabledJava(){
    result = "ВЫПОЛНЕНО";
}

// Требование 6.6
void AutoTesting::os6OnlyHTTPS(){
    result = "ВЫПОЛНЕНО";
}

// Требование 7.1
void AutoTesting::code1ValidCert(){
    result = "ВЫПОЛНЕНО";
}

// Требование 7.2
void AutoTesting::code2BuildRelease(){
    result = "ВЫПОЛНЕНО";
}

// Требование 7.3
void AutoTesting::code3DebugSymbols(){
    result = "ВЫПОЛНЕНО";
}

// Требование 7.4
void AutoTesting::code4DeveloperCode(){
    result = "ВЫПОЛНЕНО";
}

// Требование 7.5
void AutoTesting::code5ThirdPartyLib(){
    result = "ВЫПОЛНЕНО";
}

// Требование 7.6
void AutoTesting::code6ExceptionHandling(){
    result = "ВЫПОЛНЕНО";
}

// Требование 7.9
void AutoTesting::code9SecurityTools(){
    result = "ВЫПОЛНЕНО";
}


// ПРОВЕРКИ ДЛЯ 2 УРОВНЯ

// Требование 1.9
void AutoTesting::arch9CheckUpdate(){
    result = "ВЫПОЛНЕНО";
}

// Требование 2.8
void AutoTesting::data8CheckBackup(){
    result = "ВЫПОЛНЕНО";
}

// Требование 2.9
void AutoTesting::data9BackgroundMode(){
    result = "ВЫПОЛНЕНО";
}

// Требование 2.11
void AutoTesting::data11InstallPincode(){
    result = "ВЫПОЛНЕНО";
}

// Требование 5.6
void AutoTesting::net6CheckLibrary(){
    result = "ВЫПОЛНЕНО";
}

// Требование 6.9
void AutoTesting::os9ScreenOverlay(){
    result = "ВЫПОЛНЕНО";
}


// Старй шаблон, пока не удалять, тут много полезного
/*void AutoTesting::(){
    QString number = "";
    QString description = "";
    QString result = "ВЫПОЛНЕНО";

    qDebug() << "Требование №: " << number;
    qDebug() << "Описание: " << description;
    qDebug() << "Результат: " << result;

    emit endOneTest(number, description, result);

    // Файл, в котором будет храниться отчёт о тестировании
    QFile file("C:/MASVS/" + nameProject + "/" + nameProject + "_report.txt");
    file.open(QIODevice::WriteOnly | QIODevice::Text
              | QIODevice::Append );

    QTextStream a(&file);
    a.setCodec("UTF-8");
    a << "***NUMBER: " << number << " ***DESCRIPTION: " << description << " ***RESULT: " << result << endl;      // записываем результат теста в новую строку
    file.close();

    // следующю функцию выполняем немного погодя, чтобы пользователь увидел результат
    QTimer::singleShot(5000, this, SLOT());

}*/



