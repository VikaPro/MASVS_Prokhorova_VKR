import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

Page {

    Connections {
        target: _select     // все эти сигналы находятся в selectproject

        onDownloadedSource:{     // после загрузки файлов переходим к выбору уровня безопасности
            apkAndCode.visible = false
            levelSec.visible = true
        }
    }


    visible: false
    anchors.fill: parent

    header: Top{
        Item {
            id: varItem
            property string aText: "Загрузка APK и исходного кода"
            property var aPageFalse: apkAndCode
            property var aPageTrue: downloadWindow
        }
    }


    GridLayout{
        anchors.fill: parent

        ColumnLayout{
            Layout.alignment: Qt.AlignHCenter
            spacing: 40

            Label {
                text: qsTr("You are on ApkAndCode.")
                Layout.alignment: Qt.AlignHCenter
            }

            Button{
                text: "Подтвердить выбор файлов для анализа"
                Layout.alignment: Qt.AlignHCenter
                onClicked: {
                    downloadSource();
                }
            }

        }
    }
}
