import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

Page {
    visible: false
    anchors.fill: parent


    header: Top{
        Item {
            id: varItem
            property string aText: "ЗАГРУЗКА ВХОДНЫХ ДАННЫХ ДЛЯ АНАЛИЗА"
            property var aPageFalse: downloadWindow
            property var aPageTrue: selectProject
        }
    }


    GridLayout{
        anchors.fill: parent

        ColumnLayout{
            Layout.alignment: Qt.AlignHCenter
            spacing: 40

            Label {
                text: qsTr("НАПИСАТЬ, ЧТО НУЖНО СДЕЛАТЬ. УКАЗАТЬ ТОТ ФАКТ, ЧТО БЕЗ ИСХОДНИКОВ МОГУТ БЫТЬ ПРОБЛЕМЫ")
                Layout.alignment: Qt.AlignHCenter
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
}
