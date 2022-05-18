import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.3
import QtQuick.Controls.Material 2.3

Page {

    Connections {
        target: _select     // все эти сигналы находятся в selectproject

        onStartDecompile:{                   // после загрузки файла идёт его декомпиляция
            loadanimation.visible = true
            header.visible = false          // убираем, чтобы пользователь во время декомпиляции не мог уйти "назад"
        }

        onDownloadedApk:{     // после загрузки и декомпиляции файла можем перейти к выбору уровня безопасности
            loadanimation.visible = false
            onlyApk.visible = false
            levelSec.visible = true
            header.visible = true       // возвращаем, чтобы пользователь мог вернуться и выбрать другой тип входных данных
            check_file.text = "Вы выбрали для анализа приложение: " + dialog.fileUrl + "\n \nВнимание!!! Файл APK был успешно декомпилирован. \nЕсли вы хотите изменить свой выбор, то ранее записанный файл и его распакованный вид будут удалены из директории данного проекта"
        }

        onErrorApk:{    // в случае невозможности декомпилировать файл apk
            loadanimation.visible = false
            header.visible = true
            check_file.text = "Невозможно декомпилирвать выбранный файл: " + dialog.fileUrl + "\n \nПожалуйста, повторите попытку, изменив входные данные или выбрав другой тип загрузки на предыдущем шаге программы"
        }
    }

    FileDialog {                                    // Диалоговое окно для выбора шифруемого файла
        id: dialog
        title: "Выберите файл APK для анализа"
        folder: shortcuts.documents                 // стартово открывает каталог "Документы"
        //nameFilters: [ "Text files (*.apk)"]        // видим только apk файлы
        // возможно придётся убрать, смотря как хорошо будет декомпилироваться xapk
        nameFilters: [ "Text files (*.apk *.xapk)"]        // видим только apk файлы и xapk файлы
        onAccepted: {
            // при нажатии "открыть" получаем url файла типа "file:///путь/имя"
            // если файл не выбран, то кнопка для продолжения процесса не появится
            if (dialog.fileUrl != ""){
                check_file.text = "Вы выбрали для анализа приложение: " + dialog.fileUrl + "\n \nВы можете изменить своё решение, повторив попытку"
                but_confirm.visible = true  // кнопка для перехода к следующей странице
            }
        }
    }

    visible: false
    anchors.fill: parent

    header: Top{
        Item {
            id: varItem
            property string aText: "ЗАГРУЗКА APK ФАЙЛА"
            property var aPageFalse: onlyApk
            property var aPageTrue: downloadWindow
        }
    }


    ColumnLayout{
        width: 0.8 * parent.width
        anchors.centerIn: parent
        spacing: 40


        Button{
            id: but_explorer
            text: "Выбрать файл для анализа через проводник"
            Layout.alignment: Qt.AlignHCenter
            onClicked: {
                dialog.open()       // открываем проводник
            }
        }

        Label {
            id: check_file
            text: ""
            wrapMode: Text.WordWrap
            Layout.alignment: Qt.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.preferredWidth: parent.width
        }

        Button{
            id: but_confirm
            visible: false
            text: "Подтвердить выбор файла для анализа"
            Layout.alignment: Qt.AlignHCenter
            onClicked: {
                downloadApk(dialog.fileUrl);
            }
        }
    }


    Rectangle{
        id: loadanimation
        visible: false
        color: "#80CBC4"
        anchors.fill: parent
        opacity: 0.9 // прозрачность

        ColumnLayout{
            width: 0.9 * parent.width
            anchors.centerIn: parent
            spacing: 40

            Label {
                text: qsTr("Идёт декомпиляция файла APK. Это может занять несколько минут. Спасибо за терпение!")
                font.bold: true
                wrapMode: Text.WordWrap
                color: "#313031"
                font.pointSize: 14
                Layout.alignment: Qt.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.preferredWidth: parent.width
            }

            BusyIndicator {  //анимация загрузки
                Layout.alignment: Qt.AlignHCenter
                Material.accent: "#313031"
            }
        }
    }        
}
