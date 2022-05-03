import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3

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
            property string aText: "ЗАГРУЗКА APK ФАЙЛА И ИСХОДНОГО КОДА"
            property var aPageFalse: apkAndCode
            property var aPageTrue: downloadWindow
        }
    }

    ColumnLayout{
        width: 0.8 * parent.width
        anchors.centerIn: parent
        spacing: 40

        Label {
            text: qsTr("You are on ApkAndCode.")
            wrapMode: Text.WordWrap
            Layout.alignment: Qt.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.preferredWidth: parent.width
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
