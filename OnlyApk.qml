import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

Page {

    Connections {
        target: _select     // все эти сигналы находятся в selectproject

        onDownloadedApk:{     // после загрузки файлов переходим к выбору уровня безопасности
            loadanimation.visible = true
            //onlyApk.visible = false
            //levelSec.visible = true
        }

        onEndDecompile:{     // после декомпиляции файла можем перейти к выбору уровня безопасности
            loadanimation.visible = false
            onlyApk.visible = false
            levelSec.visible = true
        }
    }

    visible: false
    anchors.fill: parent

    header: Top{
        Item {
            id: varItem
            property string aText: "Загрузка APK"
            property var aPageFalse: onlyApk
            property var aPageTrue: downloadWindow
        }
    }


    GridLayout{
        anchors.fill: parent

        ColumnLayout{
            Layout.alignment: Qt.AlignHCenter
            spacing: 40

            Label {
                text: qsTr("You are on OnlyApk.")
                Layout.alignment: Qt.AlignHCenter
            }

            Button{
                text: "Подтвердить выбор файла для анализа"
                Layout.alignment: Qt.AlignHCenter
                onClicked: {
                    decompileApk();
                }
            }
        }
    }

    Rectangle{
        id: loadanimation
        visible: false
        color: "#80CBC4"
        anchors.fill: parent
        opacity: 0.5 // прозрачность

        BusyIndicator {  //анимация загрузки
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}
