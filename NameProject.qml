import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3

Page {

    Connections {
        target: _select     // все эти сигналы находятся в selectproject

        onProjectExists:{     // если проект с таким именем уже существует
            name_area.text = ""
            errorName.text = "Проект с именем '" + name + "' уже существует. Пожалуйста, введите другое название."

        }

        onNewProject:{     // если проект с таким именем уже существует
            nameProject.visible = false
            downloadWindow.visible = true
        }
    }

    visible: false
    anchors.fill: parent

    header: Top{
        Item {
            id: varItem
            property string aText: "ВЫБОР НАЗВАНИЯ НОВОГО ПРОЕКТА"
            property var aPageFalse: nameProject
            property var aPageTrue: selectProject
        }
    }

    ColumnLayout{
        width: 0.8 * parent.width
        anchors.centerIn: parent
        spacing: 40

        Label {
            text: qsTr("Данное поле обязательно для заполнения. Хорошей практикой является присвоение проекту осмысленного имени для дальнейшего упрощения и ускорения работы с анализом приложений.")
            wrapMode: Text.WordWrap
            Layout.alignment: Qt.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.preferredWidth: parent.width
        }

        ScrollView {
            focusPolicy: Qt.WheelFocus
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: 50
            Layout.preferredWidth: parent.width

            TextArea{
                id:  name_area
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
                textFormat: Text.AutoText
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                placeholderText: qsTr("Введите название нового проекта")
                placeholderTextColor : "black"
                Material.accent: "#313031"
                background: Rectangle{
                    anchors.fill: parent
                    color: "#80CBC4"
                    opacity: 0.8 //немножко прозрачный
                    radius: 5;
                }
            }
        }

        Label{
            id: errorName
            wrapMode: Text.WordWrap
            Layout.alignment: Qt.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.preferredWidth: parent.width
        }

        Button{
            Layout.alignment: Qt.AlignHCenter
            text: "ПОДТВЕРДИТЬ"

            onClicked: {
                if (name_area.text == ""){
                    errorName.text = "Пожалуйста, введите название для нового проекта."
                }
                else{
                    checkNameProject(name_area.text)
                }
            }
        }
    }
}
