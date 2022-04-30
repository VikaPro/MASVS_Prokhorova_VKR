import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3

Page {
    anchors.fill: parent

    header: Rectangle{
        id:header
        color: "#80CBC4"
        height: 50

        Label {
            text: "ГЛАВНОЕ ОКНО ПРОГРАММЫ - ВЫБОР ПРОЕКТА"
            font.pointSize: 14
            anchors.centerIn: parent
        }

    }


    GridLayout{
        anchors.fill: parent

        ColumnLayout{
            Layout.alignment: Qt.AlignHCenter
            spacing: 40

            Label {
                text: qsTr("ДОБРО ПОЖАЛОВАТЬ В ПРИЛОЖЕНИЕ. МОЖНО КРАТКО ОПИСАТЬ ДЛЯ ЧЕГО ОНО.")
                Layout.alignment: Qt.AlignHCenter
            }

            RowLayout{
                Layout.alignment: Qt.AlignHCenter

                Button{
                    text: "Протестировать новое приложение"
                    onClicked: {
                        selectProject.visible = false
                        downloadWindow.visible = true
                    }
                    highlighted: true
                    Material.accent: Material.Teal
                }

                Button{
                    text: "Открыть существующий проект"
                    highlighted: true
                    Material.background: Material.Teal
                }
            }
        }
    }
}
