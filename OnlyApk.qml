import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.3
import QtQuick.Controls.Material 2.3

Page {

    Connections {
        target: _select     // все эти сигналы находятся в selectproject

        onStartDecompile:{                   // после загрузки файла идёт его декомпиляция
            popup.open()
        }

        onDownloadedApk:{     // после загрузки и декомпиляции файла можем перейти к выбору уровня безопасности
            popup.close()
            onlyApk.visible = false
            levelSec.visible = true
        }

        onErrorApk:{    // в случае невозможности декомпилировать файл apk
            popup.close()
            check_file.text = "Невозможно декомпилирвать выбранный файл: " + dialog.fileUrl + "\nПожалуйста, повторите попытку, изменив входные данные или выбрав другой тип загрузки на предыдущем шаге программы"
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
                check_file.text = "Выбранный файл для анализа: " + dialog.fileUrl + "\nВы можете изменить своё решение, повторив попытку"
                but_confirm.enabled = true  // активируем кнопку для перехода к следующей странице
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
        height: parent.height
        width: 0.9 * parent.width
        anchors.centerIn: parent

        Label {
            id: check_file
            text: "На данном этапе необходимо выбрать APK файл мобильного приложения, которое вы хотите анализировать. Декомпиляция файла может занять некоторое время"
            color: "#ffffff"
            lineHeight: 1.1
            Layout.topMargin: 10
            font.pointSize: 12
            wrapMode: Text.WordWrap
            //font.capitalization: Font.AllUppercase
            verticalAlignment: Text.AlignBottom
            horizontalAlignment: Text.AlignHCenter
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 0.25 * parent.height
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        // Большая кнопка "ВЫБРАТЬ ФАЙЛ ДЛЯ АНАЛИЗА ПРИЛОЖЕНИЯ"
        MouseArea{
            id: but_explorer
            Layout.preferredWidth: 0.5 * parent.width
            Layout.preferredHeight: 0.4 * parent.height
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            // фон для карточки
            Rectangle{
                anchors.fill: parent
                radius: 10
                gradient: Gradient {
                    GradientStop {
                        id: grad1_all
                        position: 0.00;
                        color: "#99E1FF"
                    }
                    GradientStop {
                        id: grad2_all
                        position: 1.00;
                        color: "#57ADD1"
                    }
                }
            }

            ColumnLayout{
                anchors.fill: parent

                // Картинка нескольких файлов
                Image {
                    id: image_folder
                    Layout.maximumWidth: 256
                    Layout.maximumHeight: 256
                    Layout.preferredWidth: image_folder.height
                    Layout.preferredHeight:  0.5 * parent.height
                    Layout.topMargin: 0.05 * parent.height
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    source: "qrc:/image/image/open_folder.png"
                }

                Label {
                    text: "ВЫБРАТЬ ФАЙЛ ДЛЯ АНАЛИЗА ПРИЛОЖЕНИЯ"
                    font.pointSize: 10
                    font.weight: Font.DemiBold
                    wrapMode: Text.WordWrap
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.bottomMargin: 0.05 * parent.height
                    Layout.preferredWidth: 0.9 * parent.width
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                }
            }

            // изменение цвета карточки при наведении
            hoverEnabled: true
            onEntered: {
                grad1_all.color = "#D7F3FE"
                grad2_all.color = "#99E1FF"
            }
            onExited: {
                grad1_all.color = "#99E1FF"
                grad2_all.color = "#57ADD1"
            }
            onClicked: {
                dialog.open()       // открываем проводник
            }
        }

        Button{
            id: but_confirm
            enabled: false
            text: "ПОДТВЕРДИТЬ"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            background: Rectangle {
                Gradient {
                    id: normalGradient
                    GradientStop { position: 0.0; color: "#57CDFF" }
                    GradientStop { position: 1.0; color: "#1D84AF" }
                }
                Gradient {
                    id: hoveredGradient
                    GradientStop { position: 0.0; color: "#B8EAFF" }
                    GradientStop { position: 1.0; color: "#57ADD1" }
                }
                Gradient {
                    id: disabledGradient
                    GradientStop { position: 0.0; color: "#E2EDF3" }
                    GradientStop { position: 1.0; color: "#B0BFC4" }
                }
                implicitHeight: 40
                gradient: but_confirm.hovered ? hoveredGradient :
                          but_confirm.enabled ? normalGradient :
                          disabledGradient
                radius: 5
            }

            onClicked: {
                pushanimation.start()
                downloadApk(dialog.fileUrl);
            }

            ScaleAnimator{
                id: pushanimation
                target: but_confirm
                from: 0.9
                to: 1.0
            }
        }
    }


    // всплывающее окно
    Popup {
        id: popup
        width: 520
        height: 340
        anchors.centerIn: parent
        opacity: 0.5
        modal: true
        focus: true
        closePolicy: Popup.NoAutoClose

        ColumnLayout{
            width: parent.width
            height: parent.height
            anchors.centerIn: parent

            Label{
                text: qsTr("Идёт декомпиляция файла APK \nЭто может занять некоторое время \nСпасибо за терпение!")
                lineHeight: 1.1
                color: "#ffffff"
                font.pointSize: 12
                wrapMode: Text.WordWrap
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.preferredWidth: parent.width
                Layout.preferredHeight: 0.5 * parent.height
                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            }

            BusyIndicator{  //анимация загрузки
                Layout.preferredWidth: 80
                Layout.preferredHeight: 80
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            }
        }
    }
}
