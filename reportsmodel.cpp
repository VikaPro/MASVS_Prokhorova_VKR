#include "reportsmodel.h"
#include "selectproject.h"

#include <QDebug>
#include <QFile>
#include <QDateTime>

#include <QPrinter>
#include <QTextDocument>


ReportObject::ReportObject(const QString &p_number,
                           const QString &p_description,
                           const QString &p_result,
                           const QString &p_func)
    : m_number(p_number),
      m_description(p_description),
      m_result(p_result),
      m_func(p_func)
{
}

ReportsModel::ReportsModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

void ReportsModel::addItem(const ReportObject &newItem){
    // благодаря beginInsertRows() и endInsertRows() QML реагирует на изменения модели
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_items << newItem; // добавляем данные в модель

    qDebug() << "Добавляю модель";
    endInsertRows();
}

int ReportsModel::rowCount(const QModelIndex & parent) const{
    // метод используется ListView в QML для определения числа элементов
    Q_UNUSED(parent);
    return m_items.count();
}

QVariant ReportsModel::data(const QModelIndex & index, int role) const{
    if (index.row() < 0 || (index.row() >= m_items.count()))
        return QVariant();

    const ReportObject&itemToReturn = m_items[index.row()];

    if (role == number){
        return itemToReturn.getNumber();}

    else if (role == description)
        return itemToReturn.getDescription();

    else if (role == result)
        return itemToReturn.getResult();

    else if (role == func)
        return itemToReturn.getFunc();

    return QVariant();
}


QHash<int, QByteArray> ReportsModel::roleNames() const{
    QHash<int, QByteArray> roles;

    roles[number] = "number";
    roles[description] = "description";
    roles[result] = "result";
    roles[func] = "func";

    return roles;
}


void ReportsModel::clearR(){

    // благодаря beginInsertRows() и endInsertRows()
    // QML реагирует на изменения модели

    // очищаем только в том случае, если модель не пустая
    if (this->rowCount() != 0){
        qDebug() << "Очищаем модель!!!";
        beginRemoveRows(QModelIndex(), 0, rowCount()-1);
        m_items.clear();    // очищаем модель
        endRemoveRows();
    }
}

QString ReportObject::getNumber() const{
    return m_number;        // номер требования
}

QString ReportObject::getDescription() const{
    return m_description;   // содержание требования
}

QString ReportObject::getResult() const{
    return m_result;        // результат проверки
}

QString ReportObject::getFunc() const{
    return m_func;      // функция проверки
}


void ReportsModel::exportCSV(QString fileName){
    // Путь к файлу для сохранения из QML
    fileName.remove("file:///");
    QFile csvFile(fileName);

    // Открываем, или создаём файл, если он не существует
    if(csvFile.open(QIODevice::WriteOnly))
    {
        // Создаём текстовый поток, в который будем писать данные
        QTextStream textStream( &csvFile );
        QStringList stringList; // Вспомогательный объект QSqtringList, который сформирует строку

        // В самом начале записываем заголовок
        QString headers = "MASVS;Требование;Результат;Функция\n";
        textStream << headers;

        for(int row = 0; row < this->rowCount(); row++){
            stringList.clear(); // каждый раз очищаем stringList после записи очередной строки

            // В нашей модели всего 4 роли, т.е. 4 столбца
            // На месте нуля стоял параметр column, но тогда записывал только 1 столбец
            for (int column = 0; column < 4; column++){
                // Записываем в stringList каждый элемент таблицы

                // Для номера требования добавляем символ, чтобы csv не переводила в формат даты
                if (column == 0){
                    stringList << "№ " + this->data(this->index(row, 0), Qt::UserRole + 1 + column).toString();
                }

                else{
                    stringList << this->data(this->index(row, 0), Qt::UserRole + 1 + column).toString();
                }

                // Удалить
                qDebug() << stringList;
            }

            // После чего отправляем весь stringList в файл через текстовый поток
            // добавляя разделители в виде ";", а также поставив в конце символ переноса строки
            textStream << stringList.join( ';' ) + "\n";
        }
        csvFile.close();
    }

    // сигнал об окончании записи отчёта в файл csv
    //emit endExportCSV();
}


// переводим данные из модели в формат HTML, добавляя теги
QString ReportsModel::createHTML(){
    // Считываем данные из файла конфигурации, чтобы указать в шапке отчёта
    QString project_file = "C:/MASVS/" + nameProject + "/" + nameProject + ".conf";
    QFile file(project_file);

    file.open(QIODevice::ReadOnly);

    QStringList strList;

    while(!file.atEnd())
    {
        QString line = file.readLine();     // считываем новую строку
        line = line.trimmed();              // удаляем символы переноса строки \r\n
        strList.append(line);               // добавляем строку в список
    }

    QString create_date = strList[1].remove("Creation date: ");
    QString edit_date = strList[2].remove("Modified date: ");
    QString input_data = strList[3].remove("Input data: ");
    //QString path_apk = strList[4].remove("APK path: ");
    QString level = strList[5].remove("Security level: ");

    file.close();

    // узнаём текущую дату, чтобы тоже указать в отчёте
    QDate now = QDate::currentDate();
    QString dateStr = now.toString("dd-MM-yyyy");

    QString oneStr;     // строка для одного требования
    QString allStr;     // строка для всех требований

    // Проходимся по всем элементам модели, т.е. по всем требованиям
    for( int row = 0; row < this->rowCount(); row++ )
    {
        // Количество колонок по количеству ролей минус 1, т.к. функцию в отчёт не пишем
        for (int column = 0; column < 3; column++)
        {
            oneStr.clear();     // очищаем для чтения нового атрибута (можно и не очищать)

            // Почему то не выводит другие столбцы, тольо первый
            // Записываем каждый элемент модели в строку с нужными тегами
            QString data = this->data(this->index(row, 0), Qt::UserRole + 1 + column).toString();

            if (column == 0){
                oneStr = "<tr><td class='Col1'>" + data;
            }

            else if (column == 1){
                oneStr = "<td class='Col2'>" + data;
            }

            else if (column == 2){
                if (data == "ВЫПОЛНЕНО"){
                    oneStr = "<td class='Col3' bgcolor='#c6ffc2'>" + data;  // зелёный цвет
                }
                else if (data == "НЕ_ВЫПОЛНЕНО"){
                    oneStr = "<td class='Col3' bgcolor='#ffc2c2'>" + data;  // красный цвет
                }
                else if (data == "НЕИЗВЕСТНО"){
                    oneStr = "<td class='Col3' bgcolor='#fffec2'>" + data;  // жёлтый цвет
                }
            }
            allStr += oneStr;
        }
    }

    QString html =
    "<!DOCTYPE html> <html lang='ru'>"
    "<style>"
        "body { background-color: #dadef5; font: 12px 'Arial'; line-height: 1.5em;}"
        "table { background: #ebedf7; border-collapse: collapse; width: 90%;}"
        ".Col1 { width: 10%; text-align: center; vertical-align: middle;}"
        ".Col2 { width: 70%; text-align: left; vertical-align: middle;}"
        ".Col3 { width: 20%; text-align: center; vertical-align: middle;}"
        "TH { font-size: 12px; background: #314078; color: #ffffff; text-align: center; }"
        "TH, TD { padding: 10px; border: 1px solid #ffffff; }"
        "img { width: 100%; max-width: 150px;}"
    "</style>"

    "<body>"
        "<img src='qrc:/image/image/owasp.png'>"
        // заполняем заголовок данными из конфигурации проекта
        "<div align=left> Проект: " + nameProject + "<br> Дата создания проекта: " + create_date +
                        "<br> Дата изменения проекта: " + edit_date +
                        "<br> Тип входных данных: " + input_data + "<br> Уровень проверки безопасности: " + level +
        "<h1 align=center> <br> ОТЧЁТ О СООТВЕТСТВИИ ПРИЛОЖЕНИЯ ТРЕБОВАНИЯМ СТАНДАРТА MASVS <br> </h1>"

        "<table>"
            "<tr> <th> № <th>Требование <th> Результат"
            + allStr + // в эту таблицу с каждой строки добавляются требования из отчёта
        "</table>"

        "<div align=right> <br>Дата создания отчёта: " + dateStr + "</div>"  // текущая дата
    "</body> </html>";

    return html;
}


// попытка печати html в pdf, потом удалить отсюда
void ReportsModel::exportPDF(QString fileName){
    // Путь к файлу для сохранения из QML
    fileName.remove("file:///");

    // преобразовываем наш текстовый отчёт в формат html
    QString html = createHTML();

    // Создаём документ для экспорта
    QTextDocument document;
    document.setHtml(html);

    QPrinter printer(QPrinter::PrinterResolution);
    printer.setOutputFormat(QPrinter::PdfFormat);       // указываем формат документа
    printer.setPaperSize(QPrinter::A4);                 // задаем размер страницы
    printer.setOutputFileName(fileName);                // файл, в который экспортируем
    printer.setPageMargins(QMarginsF(50, 50, 50, 50));  // размеры полей

    document.print(&printer);                           // запускаем функцию печати отчёта в файл

    // сделать сигнал именно по окончанию печати, а не просто в конце функции
    //emit endExportPDF();
}



