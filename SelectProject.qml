import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3

Page {
    anchors.fill: parent

    header: TopEasy{

        Item {
            id: varItemEasy
            property string aTextEasy: "ГЛАВНОЕ ОКНО ПРОГРАММЫ - ВЫБОР ПРОЕКТА"
        }
    }


    ColumnLayout{
        width: 0.8 * parent.width
        anchors.centerIn: parent
        spacing: 40

        Label {
            text: qsTr("ДОБРО ПОЖАЛОВАТЬ В ПРИЛОЖЕНИЕ. МОЖНО КРАТКО ОПИСАТЬ ДЛЯ ЧЕГО ОНО.")
            wrapMode: Text.WordWrap
            Layout.alignment: Qt.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.preferredWidth: parent.width
        }

        RowLayout{
            Layout.alignment: Qt.AlignHCenter

            Button{
                text: "Протестировать новое приложение"
                onClicked: {
                    selectProject.visible = false
                    nameProject.visible = true
                }
                highlighted: true
                Material.accent: Material.Teal
            }

            Button{
                text: "Открыть существующий проект"
                //highlighted: true
                Material.background: Material.Teal
                onClicked: {
                    setListProject()
                    selectProject.visible = false
                    allProjects.visible = true
                }
            }
        }
    }
}
