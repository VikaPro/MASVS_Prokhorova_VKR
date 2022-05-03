import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3

Page {
    visible: false
    anchors.fill: parent


    header: Top{
        Item {
            id: varItem
            property string aText: "ЗАГРУЗКА ВХОДНЫХ ДАННЫХ ДЛЯ АНАЛИЗА"
            property var aPageFalse: downloadWindow
            property var aPageTrue: nameProject
        }
    }

    ColumnLayout{
        width: 0.8 * parent.width
        anchors.centerIn: parent
        spacing: 40

        Label {
            text: qsTr("НАПИСАТЬ, ЧТО НУЖНО СДЕЛАТЬ. УКАЗАТЬ ТОТ ФАКТ, ЧТО БЕЗ ИСХОДНИКОВ МОГУТ БЫТЬ ПРОБЛЕМЫ")
            wrapMode: Text.WordWrap
            Layout.alignment: Qt.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.preferredWidth: parent.width
        }

        RowLayout{
            Layout.alignment: Qt.AlignHCenter

            Button{
                text: "Только файл APK"
                onClicked: {
                    downloadWindow.visible = false
                    onlyApk.visible = true
                }
            }

            Button{
                text: "Файл APK + исходный код"
                onClicked: {
                    downloadWindow.visible = false
                    apkAndCode.visible = true
                }
            }
        }
    }
}
