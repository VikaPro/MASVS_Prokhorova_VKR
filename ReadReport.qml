import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.3
import QtQuick.Controls.Material 2.3

Page {

    Connections {
        target: _report     // все эти сигналы находятся в reportsmodel

        onEndExportCSV:{
            messageDialog.visible = true
            messageDialog.text = "Отчёт успешно экспортирован в: " + dialog_csv.fileUrl
        }

        onEndExportPDF:{
            messageDialog.visible = true
            messageDialog.text = "Отчёт успешно экспортирован в: " + dialog_pdf.fileUrl
        }
    }


    FileDialog {                                    // Диалоговое окно для выбора шифруемого файла
        id: dialog_csv
        title: "Создайте файл *.csv для экспорта отчёта"
        folder: shortcuts.documents                 // стартово открывает каталог "Документы"
        nameFilters: [ "CSV Files(*.csv)" ]         // видим только csv файлы
        selectExisting: false                       // создаем именно новые файлы
        onAccepted: {
            // при нажатии "открыть" получаем url файла типа "file:///путь/имя"
            if (dialog_csv.fileUrl != ""){
                _report.exportCSV(dialog_csv.fileUrl);            // экспортируем
            }
        }
    }

    FileDialog {                                    // Диалоговое окно для выбора шифруемого файла
        id: dialog_pdf
        title: "Создайте файл *.pdf для экспорта отчёта"
        folder: shortcuts.documents                     // стартово открывает каталог "Документы"
        nameFilters: [ "Pdf File(*.pdf)"]               // видим только pdf файлы
        selectExisting: false                           // создаем именно новые файлы
        onAccepted: {
            // при нажатии "открыть" получаем url файла типа "file:///путь/имя"
            if (dialog_pdf.fileUrl != ""){
                _report.exportPDF(dialog_pdf.fileUrl);            // экспортируем
            }
        }
    }

    // сообщаем пользователю, если отчёт успешно сохранен
    MessageDialog {
        id: messageDialog
        visible: false
        title: "Экспорт отчёта"
        icon: StandardIcon.Information
        standardButtons: StandardButton.Ok
    }


    visible: false
    anchors.fill: parent

    header: Top{
        Item {
            id: varItem
            property string aText: "ПОЛНОЦЕННЫЙ ОТЧЁТ"
            property var aPageFalse: readReport
            property var aPageTrue: allProjects
        }
    }


    ColumnLayout{
        anchors.fill: parent
        spacing: 10

        // список с карточками для всех проектов
        ListView{
            id: listView
            Layout.alignment: Qt.AlignHCenter
            Layout.fillHeight: true
            Layout.preferredWidth: 0.9 * parent.width
            Layout.bottomMargin: 40
            Layout.topMargin: 10
            spacing: 10
            model: _report // модель отчёта со всеми требованиями

            //карточка с параметрами
            delegate: Rectangle{
                width: parent.width
                height: 75
                radius: 5
                gradient: Gradient {
                    GradientStop {
                        color: "#80CBC4"
                        position: 0.00;
                    }
                    GradientStop {
                        position: 1.00;
                        color: "#000000"
                    }
                }

                GridLayout{
                    anchors.fill: parent
                    columns: 4
                    rows: 1

                    Label{          // номер требования
                        text: number
                        font.bold: true
                        Layout.column: 0
                        Layout.rightMargin: 5
                        Layout.leftMargin: 10
                        wrapMode: Text.WordWrap
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    }

                    Label{          // описание или название требования
                        text: description
                        font.pointSize: 10
                        Layout.column: 1
                        wrapMode: Text.WordWrap
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.rightMargin: 5
                        Layout.fillWidth: true
                        //Layout.preferredWidth: 0.15 * parent.width
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    }

                    Button{         // кнопка с отображением кода теста
                        text: "Код"
                        font.pointSize: 8
                        Layout.column: 2
                        Layout.rightMargin: 5
                        Layout.preferredWidth: 40
                        Layout.alignment: Qt.AlignHCenter
                        onClicked: {

                        }
                    }

                    Button{         // кнопка с результатом
                        text: result
                        font.pointSize: 8
                        Layout.column: 3
                        Layout.rightMargin: 5
                        Layout.preferredWidth: 100
                        Layout.alignment: Qt.AlignHCenter
                        onClicked: {

                        }
                    }
                }
            }
        }

        RowLayout{
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter

            Button{
                text: "Экспорт CSV"
                Layout.alignment: Qt.AlignHCenter
                onClicked: {
                    dialog_csv.open()       // открываем проводник
                }
            }
            Button{
                text: "Экспорт PDF"
                Layout.alignment: Qt.AlignHCenter
                onClicked: {
                    dialog_pdf.open()       // открываем проводник
                }
            }
        }
        Label{              // строчка с "уведомлениями" от программы
            id: check_file
            wrapMode: Text.WordWrap
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.preferredWidth: 0.9 * parent.width
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }
    }
}
