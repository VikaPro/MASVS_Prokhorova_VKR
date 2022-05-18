#include "usertesting.h"

UserTesting::UserTesting(QObject *QMLObject) : viewer(QMLObject)
{

}

void UserTesting::userTest(){
    qDebug() << "Передали уровень в ручные проверки" << levelProject;

    // обнуляем значения глобальных переменных для дальнейшего заполнения
    numbers.clear();
    descriptions.clear();

    QStringList numbersL1 = {"1"};
    QStringList descriptionsL1 = {"Уровень 1 Требование 1"};

    QStringList numbersL2 = {"2", "3"};
    QStringList descriptionsL2 = {"Уровень 2 Требование 2", "Уровень 2 Требование 3"};

    QStringList numbersR = {"4", "5", "6"};
    QStringList descriptionsR = {"Уровень R Требование 4", "Уровень R Требование 5", "Уровень R Требование 6"};

    if (levelProject == "L1"){
        // для уровня 1 не нужно объединения с другими уровнями
        numbers = numbersL1;
        descriptions = descriptionsL1;

        // посылаем сигнал в qml о количестве ручных проверок
        emit colUserTest(numbers.size());

        // показываем первую карточку для уровня L1
        oneCard(0);         // Требование 1.1
    }

    else if (levelProject == "L2"){
        // для уровня 2 нужно объединить требования 1 и 2 уровней
        numbers += numbersL1 += numbersL2;
        descriptions += descriptionsL1 += descriptionsL2;

        // посылаем сигнал в qml о количестве ручных проверок
        emit colUserTest(numbers.size());

        // показываем первую карточку для уровня L1
        oneCard(0);         // Требование 1.1
    }

    else if (levelProject == "L1 + R"){
        // для уровня L1 + R нужно объединить требования 1 и R уровней
        numbers += numbersL1 += numbersR;
        descriptions += descriptionsL1 += descriptionsR;

        // посылаем сигнал в qml о количестве ручных проверок
        emit colUserTest(numbers.size());

        // показываем первую карточку для уровня L1
        oneCard(0);         // Требование 1.1
    }

    else if (levelProject == "L2 + R"){
        // для уровня L2 + R нужно объединить требования 1, 2 и R уровней
        numbers += numbersL1 += numbersL2 += numbersR;
        descriptions += descriptionsL1 += descriptionsL2 += descriptionsR;

        // посылаем сигнал в qml о количестве ручных проверок
        emit colUserTest(numbers.size());

        // показываем первую карточку для уровня L1
        oneCard(0);         // Требование 1.1
    }

    else{
        qDebug() << "Что-то пошло не так...";
    }

    qDebug() << "Я проверяю вот столько требований: " << numbers.size();

}

void UserTesting::oneCard(int index){
    QString number = numbers[index];
    QString description = descriptions[index];

    // посылаем сигнал в QML для отображения карточки с требованием
    emit showUserCard(number, description, index);
}

void UserTesting::resultUser(QString number, QString description, QString result, int index){
    qDebug() << "Требование: " << number;
    qDebug() << "Описание: " << description;
    qDebug() << "Результат: " << result;
    qDebug() << "Следующее: " << index;
    QString function = "Пользователь";

    //Записываем данные в файл отчёта
    QFile file("C:/MASVS/" + nameProject + "/" + nameProject + ".report");
    file.open(QIODevice::WriteOnly | QIODevice::Text
              | QIODevice::Append );

    QTextStream str_file(&file);
    str_file.setCodec("UTF-8");

    // записываем результат пользовательской проверки в новую строку
    str_file << "***NUMBER: " << number << " ***DESCRIPTION: " << description << " ***RESULT: " << result << " ***FUNCTION: " << function << endl;

    file.close();

    // вызываем функцию для отображения следующего требования
    oneCard(index);
}

void UserTesting::incompleteChecks(int index){
    //Записываем данные в файл отчёта
    QFile file("C:/MASVS/" + nameProject + "/" + nameProject + ".report");
    file.open(QIODevice::WriteOnly | QIODevice::Text
              | QIODevice::Append );

    QTextStream str_file(&file);
    str_file.setCodec("UTF-8");

    QString number;
    QString description;
    QString result = "НЕИЗВЕСТНО";
    QString function = "Пользователь";

    // Завершим запись в файл самостоятельно, отметив все оставшиеся проверки Неизвестными
    for(int i = index; i < numbers.size(); i++){
        number = numbers[i];
        description = descriptions[i];
        // записываем результат пользовательской проверки в новую строку, но со статусом "НЕИЗВЕСТНО"
        str_file << "***NUMBER: " << number << " ***DESCRIPTION: " << description << " ***RESULT: " << result << " ***FUNCTION: " << function << endl;
    }

    file.close();

    qDebug() << "Все проверки записаны";

}

