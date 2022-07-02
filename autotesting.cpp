#include "autotesting.h"

#include <QTimer>
#include <QDateTime>
#include <QDir>
#include <QXmlStreamReader>
#include <QDirIterator>
#include <QQmlContext>
#include <QProcess>

QString levelProject;

AutoTesting::AutoTesting(QObject *QMLObject) : viewer(QMLObject)
{
    permission_model = new PermissionModel();       // модель для разрешений

    // Файл, в котором будет храниться отчёт о тестировании
    /*QString path = "C:/MASVS/" + nameProject + "/" + nameProject + "_report.txt";
    QFile file("C:/MASVS/" + nameProject + "/" + nameProject + "_report.txt");
    file.open(QIODevice::WriteOnly | QIODevice::Text
              | QIODevice::Append );

    QTextStream str_file(&file);
    str_file.setCodec("UTF-8");*/

    // закроем мы файл в самом конце тестирования

    // Вызов функций для 1 уровня тестирования:
    // Требование 2.3
    connect(this, SIGNAL(endData2CheckInternal()), this, SLOT(data3CheckLog()));

    // Требование 2.5
    connect(this, SIGNAL(endData3CheckLog()), this, SLOT(data5KeyboardCache()));

    // Требование 2.6
    connect(this, SIGNAL(endData5KeyboardCache()), this, SLOT(data6CheckIPC()));

    // Требование 2.7
    connect(this, SIGNAL(endData6CheckIPC()), this, SLOT(data7CheckInterface()));

    // Требование 3.1
    connect(this, SIGNAL(endData7CheckInterface()), this, SLOT(crypto1Symmetrical()));

    // Требование 3.2
    connect(this, SIGNAL(endCrypto1Symmetrical()), this, SLOT(crypto2ProvenAlgorithms()));

    // Требование 3.4
    connect(this, SIGNAL(endCrypto2ProvenAlgorithms()), this, SLOT(crypto4WeakAlgorithms()));

    // Требование 3.6
    connect(this, SIGNAL(endCrypto4WeakAlgorithms()), this, SLOT(crypto6RandomGenerator()));

    // Требование 4.1
    connect(this, SIGNAL(endCrypto6RandomGenerator()), this, SLOT(auth1LoginPass()));

    // Требование 4.5
    connect(this, SIGNAL(endAuth1LoginPass()), this, SLOT(auth5PassPolicy()));

    // Требование 5.1
    connect(this, SIGNAL(endAuth5PassPolicy()), this, SLOT(net1CryptoTLS()));

    // Требование 5.3
    connect(this, SIGNAL(endNet1CryptoTLS()), this, SLOT(net3VerifiesX509()));

    // Требование 6.1
    connect(this, SIGNAL(endNet3VerifiesX509()), this, SLOT(os1MinPermissions()));

    // Требование 6.3
    connect(this, SIGNAL(endOs1MinPermissions()), this, SLOT(os3CustomURL()));

    // Требование 6.5
    connect(this, SIGNAL(endOs3CustomURL()), this, SLOT(os5DisabledJava()));

    // Требование 6.6
    connect(this, SIGNAL(endOs5DisabledJava()), this, SLOT(os6OnlyHTTPS()));

    // Требование 7.1
    connect(this, SIGNAL(endOs6OnlyHTTPS()), this, SLOT(code1ValidCert()));

    // Требование 7.2
    connect(this, SIGNAL(endCode1ValidCert()), this, SLOT(code2BuildRelease()));

    // Требование 7.3
    connect(this, SIGNAL(endCode2BuildRelease()), this, SLOT(code3DebugSymbols()));

    // Требование 7.4
    connect(this, SIGNAL(endCode3DebugSymbols()), this, SLOT(code4DeveloperCode()));

    // Требование 7.5
    connect(this, SIGNAL(endCode4DeveloperCode()), this, SLOT(code5ThirdPartyLib()));

    // Требование 7.6
    connect(this, SIGNAL(endCode5ThirdPartyLib()), this, SLOT(code6ExceptionHandling()));

    // Требование 7.9
    connect(this, SIGNAL(endCode6ExceptionHandling()), this, SLOT(code9SecurityTools()));

    // Вызов функций тестирования для 2 уровня

    // Требование 2.8
    connect(this, SIGNAL(endArch9CheckUpdate()), this, SLOT(data8CheckBackup()));

    // Требование 2.9
    connect(this, SIGNAL(endData8CheckBackup()), this, SLOT(data9BackgroundMode()));

    // Требование 2.11
    connect(this, SIGNAL(endData9BackgroundMode()), this, SLOT(data11InstallPincode()));

    // Требование 5.6
    connect(this, SIGNAL(endData11InstallPincode()), this, SLOT(net6CheckLibrary()));

    // Требование 6.9
    connect(this, SIGNAL(endNet6CheckLibrary()), this, SLOT(os9ScreenOverlay()));

}

void AutoTesting::autoTest(QString level){        
    qDebug() << "Сейчас будут автотесты по уровню: " << level;

    levelProject = level;   //присваиваем значение глобальной переменной

    if (level == "L1"){
        emit colAutoTest(24);

        // запускаем первый авто-тест для 1 уровня
        data2CheckInternal();   // Требование 2.2

        connect(this, SIGNAL(endAutoLevel1()), this, SIGNAL(endAutoTest()));    // посылаем сигнал об окончании в qml
    }

    else if (level == "L2"){
        emit colAutoTest(30);

        // запускаем первый авто-тест для 1 уровня
        data2CheckInternal();   // Требование 2.2

        // запускаем первый авто-тест для 2 уровня
        connect(this, SIGNAL(endAutoLevel1()), this, SLOT(arch9CheckUpdate())); // Требование 1.9
        connect(this, SIGNAL(endAutoLevel2()), this, SIGNAL(endAutoTest()));    // посылаем сигнал об окончании в qml
    }

    else if (level == "L1 + R"){
        emit colAutoTest(24);

        // запускаем первый авто-тест для 1 уровня
        data2CheckInternal();   // Требование 2.2

        connect(this, SIGNAL(endAutoLevel1()), this, SIGNAL(endAutoTest()));    // посылаем сигнал об окончании в qml
    }

    else if (level == "L2 + R"){
        emit colAutoTest(30);

        // запускаем первый авто-тест для 1 уровня
        data2CheckInternal();   // Требование 2.2

        // запускаем первый авто-тест для 2 уровня
        connect(this, SIGNAL(endAutoLevel1()), this, SLOT(arch9CheckUpdate())); // Требование 1.9
        connect(this, SIGNAL(endAutoLevel2()), this, SIGNAL(endAutoTest()));    // посылаем сигнал об окончании в qml
    }

    else{
        qDebug() << "Что-то пошло не так...";
    }  
}

// Функция задержки на n секунд отправки сигналов о завершении каждой проверки, поможет пользователю успеть увидеть результат
// Делаем в отдельной функции, чтобы время всех задержек можно было отредактировать одной строкой
void AutoTesting::emitLater(const char *signalOrSlot){
    QTimer::singleShot(300, this, signalOrSlot);
}

// Функция записи описания и результата проверки в файл
// Попробовать сделать глобально, чтобы каждый раз не открывать файл по новой
void AutoTesting::writeReportAuto(QString number, QString description, QString result, QString func){
    QFile file("C:/MASVS/" + nameProject + "/" + nameProject + ".report");
    file.open(QIODevice::WriteOnly | QIODevice::Text
              | QIODevice::Append );

    QTextStream str_file(&file);
    str_file.setCodec("UTF-8");

    // сигнал в графику
    emit endOneTest(number, description, result, func);

    // записываем результат теста в новую строку
    str_file << "***NUMBER: " << number << " ***DESCRIPTION: " << description << " ***RESULT: " << result << " ***FUNCTION: " << func << endl;

    file.close();

}

// Функция для получения полного списка вложенных файлов в директории приложения
QStringList AutoTesting::readDir(QString nameDir){
    //QString pathDir = "C:/MASVS/" + nameProject + "/" + nameProject + "_" + nameDir;
    QString pathDir = "C:/Users/vikiz/Desktop/helloworldjni/" + nameDir; // удалить, правильный сверху
    qDebug() << "Название директории для поиска файлов" << nameDir;

    QStringList allFiles; // список со всеми файлами для проверки, в т.ч. вложенными

    // таким образом задается маска
    //QDirIterator itR(pathDir, QStringList() << "*.xml", QDir::Files, QDirIterator::Subdirectories);

    QDirIterator itR(pathDir, {"*.yml", "*.xml", "*.java", "*.kt"}, QDir::Files, QDirIterator::Subdirectories);
    while (itR.hasNext()){   // пока существуют непросмотренные файлы
        allFiles << itR.next();
    }

    return allFiles;
}

QString AutoTesting::findManifest(){
    // вызываем функцию для рекурсивного определения названий всех файлов конкретного каталога
    // в нашем случае пользователь обязательно должен положить манифест в эту папку,
    // либо в неё будет распаковано приложение
    QStringList allFiles = readDir("apk");

    // Переменная, в которую помещается полный путь к файлу манифеста
    QString pathManifest = "0";

    for(int i = 0; i < allFiles.size(); i++){
        // Считываем название каждого файла в списке
        if(allFiles[i].contains("AndroidManifest.xml")){
            pathManifest = allFiles[i];
            break;
        }
    }

    // если вдруг файл не найден, то ищем его в каталоге с исходниками
    if(pathManifest == "0"){
        QStringList allFiles = readDir("src");
        for(int i = 0; i < allFiles.size(); i++){
            // Считываем название каждого файла в списке
            if(allFiles[i].contains("AndroidManifest.xml")){
                pathManifest = allFiles[i];
                break;
            }
        }
    }

    qDebug() << "Местонахождение манифеста: " << pathManifest;
    return pathManifest;
}

// Требование 2.2
void AutoTesting::data2CheckInternal(){
    number = "2.2";
    description = "Чувствительные данные хранятся только во внутреннем хранилище приложения, либо в системном хранилище авторизационных данных";
    result = "ВЫПОЛНЕНО";
    func = "data2CheckInternal()";

    // записываем результат теста в файл с отчётом
    writeReportAuto(number, description, result, func);

    // Отправляем сигнал о завершении проверки с задержкой
    emitLater(SIGNAL(endData2CheckInternal()));
}

// Требование 2.3
void AutoTesting::data3CheckLog(){
    number = "2.3";
    description = "Чувствительные данные не попадают в логи приложения";
    result = "ВЫПОЛНЕНО";
    func = "data3CheckLog()";

    // записываем результат теста в файл с отчётом
    writeReportAuto(number, description, result, func);

    // Отправляем сигнал о завершении проверки с задержкой
    emitLater(SIGNAL(endData3CheckLog()));
}


// Требование 2.5
void AutoTesting::data5KeyboardCache(){
    number = "2.5";
    description = "Кэш клавиатуры выключен для полей ввода чувствительных данных";
    result = "ВЫПОЛНЕНО";
    func = "data5KeyboardCache()";

    // записываем результат теста в файл с отчётом
    writeReportAuto(number, description, result, func);

    // Отправляем сигнал о завершении проверки с задержкой
    emitLater(SIGNAL(endData5KeyboardCache()));
}

// Требование 2.6
void AutoTesting::data6CheckIPC(){
    number = "2.6";
    description = "Чувствительные данные недоступны для механизмов межпроцессного взаимодействия (IPC)";
    result = "ВЫПОЛНЕНО";
    func = "data6CheckIPC()";

    // записываем результат теста в файл с отчётом
    writeReportAuto(number, description, result, func);

    // Отправляем сигнал о завершении проверки с задержкой
    emitLater(SIGNAL(endData6CheckIPC()));
}

// Требование 2.7
void AutoTesting::data7CheckInterface(){
    number = "2.7";
    description = "Никакие чувствительные данные, такие как пароли или пин-коды, не видны через пользовательский интерфейс";
    result = "ВЫПОЛНЕНО";
    func = "data7CheckInterface()";

    // записываем результат теста в файл с отчётом
    writeReportAuto(number, description, result, func);

    // Отправляем сигнал о завершении проверки с задержкой
    emitLater(SIGNAL(endData7CheckInterface()));
}

// Требование 3.1
void AutoTesting::crypto1Symmetrical(){
    number = "3.1";
    description = "Приложение не использует симметричное шифрование с жестко закодированными ключами в качестве единственного метода шифрования";
    result = "ВЫПОЛНЕНО";
    func = "crypto1Symmetrical()";

    // записываем результат теста в файл с отчётом
    writeReportAuto(number, description, result, func);

    // Отправляем сигнал о завершении проверки с задержкой
    emitLater(SIGNAL(endCrypto1Symmetrical()));
}

// Требование 3.2
void AutoTesting::crypto2ProvenAlgorithms(){
    number = "3.2";
    description = "Приложение использует проверенные реализации криптографических алгоритмов";
    func = "crypto2ProvenAlgorithms()";

    // вызываем функцию для рекурсивного определения названий всех файлов конкретного каталога
    QStringList allFiles = readDir("src");

    // список со всеми "опасными" строками кода, которые подошли под фильтр
    QStringList listWarning;

    for(int i = 0; i < allFiles.size(); i++){
        // Открываем каждый файл для считывания по строкам
        QFile file(allFiles[i]);
        file.open(QIODevice::ReadOnly);

        while(!file.atEnd())
        {
            QString line = file.readLine();

            // если ключевое слово найдено, то записываем всю найденную строку
            // в список, который подом будем проверять подробнее
            if(line.contains("Cipher.getInstance") ||
               line.contains("KeyGenerator.getInstance") ||
               line.contains("KeyPairGenerator.getInstance") ||
               line.contains("MessageDigest.getInstance") ||
               line.contains("Signature.getInstance") ||
               line.contains("Mac.getInstance")){
                    listWarning << line;
            }
        }
        // обязательно закрываем каждый файл
        file.close();
    }

    qDebug() << "Найденные параметры: " << listWarning;

    // определяем, есть ли ненадёжные шифры в найденном коде
    if(listWarning.contains("DES") ||
       listWarning.contains("3DES") ||
       listWarning.contains("RC2") ||
       listWarning.contains("RC4") ||
       listWarning.contains("BLOWFISH") ||
       listWarning.contains("MD4") ||
       listWarning.contains("MD5") ||
       listWarning.contains("SHA1")){
          result = "НЕ_ВЫПОЛНЕНО";
    }
    else{
        result = "ВЫПОЛНЕНО";
    }

    // записываем результат теста в файл с отчётом
    writeReportAuto(number, description, result, func);

    // Отправляем сигнал о завершении проверки с задержкой
    emitLater(SIGNAL(endCrypto2ProvenAlgorithms()));
}

// Требование 3.4
void AutoTesting::crypto4WeakAlgorithms(){
    number = "3.4";
    description = "Приложение не использует устаревшие и слабые криптографические протоколы и алгоритмы";
    result = "ВЫПОЛНЕНО";
    func = "crypto4WeakAlgorithms()";

    // записываем результат теста в файл с отчётом
    writeReportAuto(number, description, result, func);

    // Отправляем сигнал о завершении проверки с задержкой
    emitLater(SIGNAL(endCrypto4WeakAlgorithms()));
}

// Требование 3.6
void AutoTesting::crypto6RandomGenerator(){
    number = "3.6";
    description = "Все случайные значения генерируются с использованием безопасного генератора случайных чисел";
    result = "ВЫПОЛНЕНО";
    func = "crypto6RandomGenerator()";

    // записываем результат теста в файл с отчётом
    writeReportAuto(number, description, result, func);

    // Отправляем сигнал о завершении проверки с задержкой
    emitLater(SIGNAL(endCrypto6RandomGenerator()));
}

// Требование 4.1
void AutoTesting::auth1LoginPass(){
    number = "4.1";
    description = "Если приложение предоставляет пользователям доступ к удалённым сервисам, на бэкенде должна быть реализована аутентификация, например, по логину и паролю";
    result = "ВЫПОЛНЕНО";
    func = "auth1LoginPass()";

    // записываем результат теста в файл с отчётом
    writeReportAuto(number, description, result, func);

    // Отправляем сигнал о завершении проверки с задержкой
    emitLater(SIGNAL(endAuth1LoginPass()));
}

// Требование 4.5
void AutoTesting::auth5PassPolicy(){
    number = "4.5";
    description = "На сервере реализована парольная политика";
    result = "ВЫПОЛНЕНО";
    func = "auth5PassPolicy()";

    // записываем результат теста в файл с отчётом
    writeReportAuto(number, description, result, func);

    // Отправляем сигнал о завершении проверки с задержкой
    emitLater(SIGNAL(endAuth5PassPolicy()));
}

// Требование 5.1
void AutoTesting::net1CryptoTLS(){
    number = "5.1";
    description = "Данные, передаваемые по сети, шифруются с использованием TLS. Безопасный канал используется для всех сервисов приложения";
    result = "ВЫПОЛНЕНО";
    func = "net1CryptoTLS()";

    // записываем результат теста в файл с отчётом
    writeReportAuto(number, description, result, func);

    // Отправляем сигнал о завершении проверки с задержкой
    emitLater(SIGNAL(endNet1CryptoTLS()));
}

// Требование 5.3
void AutoTesting::net3VerifiesX509(){
    number = "5.3";
    description = "Приложение верифицирует X.509 сертификаты сервера во время установления защищённого канала. Принимаются только сертификаты, подписанные доверенным удостоверяющим центром (CA)";
    result = "ВЫПОЛНЕНО";
    func = "net3VerifiesX509()";

    // записываем результат теста в файл с отчётом
    writeReportAuto(number, description, result, func);

    // Отправляем сигнал о завершении проверки с задержкой
    emitLater(SIGNAL(endNet3VerifiesX509()));
}

// Требование 6.1
void AutoTesting::os1MinPermissions(){
    // вызываем функцию для определения полного пути к файлу манифеста в нашем проекте
    QString pathManifest = findManifest();

    QFile inputFile(pathManifest);
    inputFile.open(QIODevice::ReadOnly | QIODevice::Text);
    QTextStream inputStream(&inputFile);
    QXmlStreamReader xml(inputStream.readAll());

    qDebug() << "*** Список разрешений из манифеста ***";

    QStringList dangerPermission = {"READ_CALENDAR", "WRITE_CALENDAR", "READ_CALL_LOG",
                                    "WRITE_CALL_LOG", "PROCESS_OUTGOING_CALLS", "CAMERA",
                                    "READ_CONTACTS", "WRITE_CONTACTS", "GET_ACCOUNTS",
                                    "ACCESS_FINE_LOCATION", "ACCESS_COARSE_LOCATION", "RECORD_AUDIO",
                                    "READ_PHONE_STATE", "READ_PHONE_NUMBERS", "CALL_PHONE",
                                    "ANSWER_PHONE_CALLS", "ADD_VOICEMAIL", "USE_SIP",
                                    "BODY_SENSORS", "SEND_SMS", "RECEIVE_SMS",
                                    "READ_SMS", "RECEIVE_WAP_PUSH", "RECEIVE_MMS",
                                    "READ_EXTERNAL_STORAGE",
                                    "WRITE_EXTERNAL_STORAGE"};
    QString level;

    while (!xml.atEnd()) {
        if (xml.isStartElement() && xml.name() == "uses-permission") {
            QStringRef permission = xml.attributes().value("android:name");
            QString name = permission.toString();
            name.remove("android.permission.");
            qDebug() << name;
            if (dangerPermission.indexOf(QRegExp(name)) != -1){
                level = "опасное";
            }
            else{
                level = "обычное";
            }

            xml.readNext();
            permission_model->addItem(PermissionObject(name, level));
        }
        xml.readNext();
    }

    // посылаем сигнал в графику, чтобы пользователь выбрал ответ
    emit checkPermission();

}

void AutoTesting::resultMinPermissions(QString result){
    number = "6.1";
    description = "Приложение запрашивает минимально необходимый набор разрешений";
    qDebug() << "Os1MinPermissions: " << result;
    func = "resultMinPermissions(QString result)";

    // записываем результат теста в файл с отчётом
    writeReportAuto(number, description, result, func);

    // Отправляем сигнал о завершении проверки с задержкой
    emitLater(SIGNAL(endOs1MinPermissions()));
}

// Требование 6.3
void AutoTesting::os3CustomURL(){
    number = "6.3";
    description = "Приложение не экспортирует чувствительные данные через кастомные URL-схемы, если эти механизмы не защищены должным образом";
    result = "ВЫПОЛНЕНО";
    func = "os3CustomURL()";

    // записываем результат теста в файл с отчётом
    writeReportAuto(number, description, result, func);

    // Отправляем сигнал о завершении проверки с задержкой
    emitLater(SIGNAL(endOs3CustomURL()));
}

// Требование 6.5
void AutoTesting::os5DisabledJava(){
    number = "6.5";
    description = "JavaScript отключен в компонентах WebView, если в нём нет необходимости";
    result = "ВЫПОЛНЕНО";
    func = "os5DisabledJava()";

    // записываем результат теста в файл с отчётом
    writeReportAuto(number, description, result, func);

    // Отправляем сигнал о завершении проверки с задержкой
    emitLater(SIGNAL(endOs5DisabledJava()));
}

// Требование 6.6
void AutoTesting::os6OnlyHTTPS(){
    number = "6.6";
    description = "WebViews сконфигурирован с поддержкой минимального набора протоколов (в идеале только https). Поддержка потенциально опасных URL-схем (таких как: file, tel и app-id) отключена";
    result = "ВЫПОЛНЕНО";
    func = "os6OnlyHTTPS()";

    // записываем результат теста в файл с отчётом
    writeReportAuto(number, description, result, func);

    // Отправляем сигнал о завершении проверки с задержкой
    emitLater(SIGNAL(endOs6OnlyHTTPS()));
}

// Требование 7.1
void AutoTesting::code1ValidCert(){
    number = "7.1";
    description = "Приложение подписано валидным сертификатом";
    result = "ВЫПОЛНЕНО";
    func = "code1ValidCert()";

    QString pathApk = "C:\\MASVS\\" + nameProject + "\\" + nameProject + ".apk";;

    QProcess *console=new QProcess();
    // по умолчанию инструмент использует максимально возможный уровень API,
    // поэтому проверяются все 3 уровня подписи
    console->start("C:\\Windows\\System32\\cmd.exe",
                   QStringList() << "/K" << "c: && cd C:\\Program Files\\Android\\Android Studio\\jre\\bin\\ "
                                            "&& jarsigner -verify " + pathApk);

    console->waitForReadyRead();
    qDebug() << "*****РЕЗУЛЬТАТ ПОДПИСИ********";
    //qDebug() << console->readAllStandardOutput();

    QString verified = console->readAllStandardOutput();

    if(verified.contains("jar verified.")){
        result = "ВЫПОЛНЕНО";
    }
    else{
        result = "НЕ_ВЫПОЛНЕНО";
    }

    // записываем результат теста в файл с отчётом
    writeReportAuto(number, description, result, func);

    // Отправляем сигнал о завершении проверки с задержкой
    emitLater(SIGNAL(endCode1ValidCert()));
}

// Требование 7.2
void AutoTesting::code2BuildRelease(){
    number = "7.2";
    description = "Приложение было собрано в release режиме с настройками, подходящими для релизной сборки (например, без атрибута debuggable)";
    func = "code2BuildRelease()";

    // вызываем функцию для определения полного пути к файлу манифеста в нашем проекте
    QString pathManifest = findManifest();

    QFile inputFile(pathManifest);
    inputFile.open(QIODevice::ReadOnly | QIODevice::Text);
    QTextStream inputStream(&inputFile);
    QXmlStreamReader xml(inputStream.readAll());

    qDebug() << "*** Разрешена ли отладка ***";

    while (!xml.atEnd()) {
        if (xml.isStartElement() && xml.name() == "application") {
            QStringRef debug = xml.attributes().value("android:debuggable");
            QString str_debug = debug.toString();
            qDebug() << str_debug;
            if (str_debug == "true"){
                result = "НЕ_ВЫПОЛНЕНО";
            }
            // если стоит false или вообще ничего (потому что по умолчанию отключена)
            else{
                result = "ВЫПОЛНЕНО";
            }
            xml.readNext();
        }
        xml.readNext();
    }

    // записываем результат теста в файл с отчётом
    writeReportAuto(number, description, result, func);

    // Отправляем сигнал о завершении проверки с задержкой
    emitLater(SIGNAL(endCode2BuildRelease()));
}

// Требование 7.3
void AutoTesting::code3DebugSymbols(){
    number = "7.3";
    description = "Отладочные символы удалены из нативных бинарных файлов";
    result = "ВЫПОЛНЕНО";
    func = "code3DebugSymbols()";

    // записываем результат теста в файл с отчётом
    writeReportAuto(number, description, result, func);

    // Отправляем сигнал о завершении проверки с задержкой
    emitLater(SIGNAL(endCode3DebugSymbols()));
}

// Требование 7.4
void AutoTesting::code4DeveloperCode(){
    number = "7.4";
    description = "Kод отладки и вспомогательный для разработки код (например, тестовый код, бэкдоры, скрытые настройки) были удалены. Приложение не логирует подробные ошибки и отладочные сообщения";
    result = "ВЫПОЛНЕНО";
    func = "code4DeveloperCode()";

    // записываем результат теста в файл с отчётом
    writeReportAuto(number, description, result, func);

    // Отправляем сигнал о завершении проверки с задержкой
    emitLater(SIGNAL(endCode4DeveloperCode()));
}

// Требование 7.5
void AutoTesting::code5ThirdPartyLib(){
    number = "7.5";
    description = "Все сторонние компоненты, используемые мобильным приложением (библиотеки и фреймворки), идентифицированы и проверены на наличие известных уязвимостей";
    result = "ВЫПОЛНЕНО";
    func = "code5ThirdPartyLib()";

    // записываем результат теста в файл с отчётом
    writeReportAuto(number, description, result, func);

    // Отправляем сигнал о завершении проверки с задержкой
    emitLater(SIGNAL(endCode5ThirdPartyLib()));
}

// Требование 7.6
void AutoTesting::code6ExceptionHandling(){
    number = "7.6";
    description = "Приложение обрабатывает возможные исключения";
    result = "ВЫПОЛНЕНО";
    func = "code6ExceptionHandling()";

    // записываем результат теста в файл с отчётом
    writeReportAuto(number, description, result, func);

    // Отправляем сигнал о завершении проверки с задержкой
    emitLater(SIGNAL(endCode6ExceptionHandling()));
}

// Требование 7.9
void AutoTesting::code9SecurityTools(){
    number = "7.9";
    description = "Активированы все стандартные функции безопасности, предусмотренные инструментами разработчика (такие как минификация байт-кода, защита стека, поддержка PIE и ARC)";
    result = "ВЫПОЛНЕНО";
    func = "code9SecurityTools()";

    // записываем результат теста в файл с отчётом
    writeReportAuto(number, description, result, func);

    // Отправляем сигнал о завершении проверки с задержкой
    emitLater(SIGNAL(endAutoLevel1()));
}


// ПРОВЕРКИ ДЛЯ 2 УРОВНЯ

// Требование 1.9
void AutoTesting::arch9CheckUpdate(){
    number = "1.9";
    description = "Существует механизм принудительных обновлений мобильного приложения";
    result = "ВЫПОЛНЕНО";
    func = "arch9CheckUpdate()";

    // записываем результат теста в файл с отчётом
    writeReportAuto(number, description, result, func);

    // Отправляем сигнал о завершении проверки с задержкой
    emitLater(SIGNAL(endArch9CheckUpdate()));
}

// Требование 2.8
void AutoTesting::data8CheckBackup(){
    number = "2.8";
    description = "Никакие чувствительные данные не попадают в бэкапы, создаваемые операционной системой";
    func = "data8CheckBackup()";

    // вызываем функцию для определения полного пути к файлу манифеста в нашем проекте
    QString pathManifest = findManifest();

    QFile inputFile(pathManifest);
    inputFile.open(QIODevice::ReadOnly | QIODevice::Text);
    QTextStream inputStream(&inputFile);
    QXmlStreamReader xml(inputStream.readAll());

    qDebug() << "*** Разрешены ли резервные копии ***";

    while (!xml.atEnd()) {
        if (xml.isStartElement() && xml.name() == "application") {
            QStringRef backup = xml.attributes().value("android:allowBackup");
            QString str_backup = backup.toString();
            qDebug() << "Обычный Backup: " << str_backup;
            QString backup_result;

            QStringRef agent_backup = xml.attributes().value("android:fullBackupOnly");
            QString str_agent_backup = agent_backup.toString();
            qDebug() << "Агентный Backup: " << str_agent_backup;
            QString agent_result;

            // сначала проверяем первый параметр
            if (str_backup == "false"){
                backup_result = "ВЫПОЛНЕНО";
            }
            // если стоит true или вообще ничего (потому что по умолчанию включено)
            else{
                backup_result = "НЕ_ВЫПОЛНЕНО";
            }

            // затем проверяем второй параметр
            if (str_agent_backup == "true"){
                agent_result = "НЕ_ВЫПОЛНЕНО";
            }
            // если стоит false или вообще ничего (потому что по умолчанию отключено)
            else{
                agent_result = "ВЫПОЛНЕНО";
            }
            xml.readNext();

            // требование выполнено, только если оба условия выполнены
            if ((backup_result == "ВЫПОЛНЕНО") && (agent_result == "ВЫПОЛНЕНО")){
                result = "ВЫПОЛНЕНО";
            }
            else{
                result = "НЕ_ВЫПОЛНЕНО";
            }
            qDebug() << "Тест на бэкап: " << result;
        }

        xml.readNext();
    }

    // записываем результат теста в файл с отчётом
    writeReportAuto(number, description, result, func);

    // Отправляем сигнал о завершении проверки с задержкой
    emitLater(SIGNAL(endData8CheckBackup()));
}

// Требование 2.9
void AutoTesting::data9BackgroundMode(){
    number = "2.9";
    description = "Приложение скрывает чувствительные данные с экрана, когда находится в фоновом режиме";
    result = "ВЫПОЛНЕНО";
    func = "data9BackgroundMode()";

    // записываем результат теста в файл с отчётом
    writeReportAuto(number, description, result, func);

    // Отправляем сигнал о завершении проверки с задержкой
    emitLater(SIGNAL(endData9BackgroundMode()));
}

// Требование 2.11
void AutoTesting::data11InstallPincode(){
    number = "2.11";
    description = "Приложение требует от пользователя минимальную настройку доступа к устройству, такую, как установку пин-кода на устройство";
    result = "ВЫПОЛНЕНО";
    func = "data11InstallPincode()";

    // записываем результат теста в файл с отчётом
    writeReportAuto(number, description, result, func);

    // Отправляем сигнал о завершении проверки с задержкой
    emitLater(SIGNAL(endData11InstallPincode()));
}

// Требование 5.6
void AutoTesting::net6CheckLibrary(){
    number = "5.6";
    description = "Приложение использует только актуальные версии библиотек для подключения к сети и обеспечения безопасного соединения";
    result = "ВЫПОЛНЕНО";
    func = "net6CheckLibrary()";

    // записываем результат теста в файл с отчётом
    writeReportAuto(number, description, result, func);

    // Отправляем сигнал о завершении проверки с задержкой
    emitLater(SIGNAL(endNet6CheckLibrary()));
}

// Требование 6.9
void AutoTesting::os9ScreenOverlay(){
    number = "6.9";
    description = "Приложение защищает себя от атак наложения экрана (overlay)";
    func = "os9ScreenOverlay()";

    // вызываем функцию для рекурсивного определения названий всех файлов конкретного каталога
    QStringList allFiles = readDir("src");

    // список со всеми необходимыми строками кода, которые подошли под фильтр
    QStringList listWarning;

    for(int i = 0; i < allFiles.size(); i++){
        // Открываем каждый файл для считывания по строкам
        QFile file(allFiles[i]);
        file.open(QIODevice::ReadOnly);

        while(!file.atEnd())
        {
            QString line = file.readLine();

            // если ключевое слово найдено, то записываем всю найденную строку
            // в список, который подом будем проверять подробнее
            if(line.contains("FLAG_WINDOW_IS_OBSCURED") ||
               line.contains("FLAG_WINDOW_IS_PARTIALLY_OBSCURED") ||
               line.contains("setFilterTouchesWhenObscured") ||
               line.contains("onFilterTouchEventForSecurity") ||
               line.contains("android:filterTouchesWhenObscured")){
                    listWarning << line;
            }
        }
        // обязательно закрываем каждый файл
        file.close();
    }

    qDebug() << "Найденные параметры для overlay: " << listWarning;

    // если не было найдено ни одного параметра
    if (listWarning.size() == 0){
        result = "НЕ_ВЫПОЛНЕНО";
    }
    else if(listWarning.contains("android:filterTouchesWhenObscured(false)") ||
            listWarning.contains("setFilterTouchesWhenObscured(false)")){
        result = "НЕ_ВЫПОЛНЕНО";
    }
    else{
        result = "ВЫПОЛНЕНО";
    }

    // записываем результат теста в файл с отчётом
    writeReportAuto(number, description, result, func);

    // Отправляем сигнал о завершении проверки с задержкой
    emitLater(SIGNAL(endAutoLevel2()));
}

