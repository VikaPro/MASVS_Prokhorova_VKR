import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3

Page {

    Connections {
        target: _select     // все эти сигналы находятся в selectproject

        onDownloadedApk:{     // после загрузки файлов переходим к выбору уровня безопасности
            loadanimation.visible = true
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
            property string aText: "ЗАГРУЗКА APK ФАЙЛА"
            property var aPageFalse: onlyApk
            property var aPageTrue: downloadWindow
        }
    }


    ColumnLayout{
        width: 0.8 * parent.width
        anchors.centerIn: parent
        spacing: 40

        Label {
            text: qsTr("You are on OnlyApk.")
            wrapMode: Text.WordWrap
            Layout.alignment: Qt.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.preferredWidth: parent.width
        }

        Button{
            text: "Подтвердить выбор файла для анализа"
            Layout.alignment: Qt.AlignHCenter
            onClicked: {
                decompileApk();
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
