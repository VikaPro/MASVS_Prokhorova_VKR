import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12
import QtQuick.Controls.Material 2.3

Page {
    visible: false
    anchors.fill: parent

    Connections {
        target: _select     // все эти сигналы находятся в selectproject

        onProjectExists:{     // если проект с таким именем уже существует
            name_area.text = ""
            errorPopup.text = "Проект с именем '" + name + "' уже существует \n Пожалуйста, введите другое название"
            createPopup.start()
        }

        onNewProject:{     // если проект с таким именем уже существует
            nameProject.visible = false
            downloadWindow.visible = true
        }
    }

    header: Top{
        Item {
            id: varItem
            property string aText: "ВЫБОР НАЗВАНИЯ НОВОГО ПРОЕКТА"
            property var aPageFalse: nameProject
            property var aPageTrue: selectProject
        }
    }

    ColumnLayout{
        height: parent.height
        width: 0.8 * parent.width
        anchors.centerIn: parent

        Label {
            id: lable
            color: "#ffffff"
            lineHeight: 1.1
            Layout.topMargin: 10
            text: "Данное поле обязательно для заполнения \nХорошей практикой является присвоение проекту осмысленного имени для дальнейшего упрощения и ускорения работы с анализом приложений"
            font.capitalization: Font.AllUppercase
            wrapMode: Text.WordWrap
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.preferredWidth: parent.width
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
        }

        ScrollView {
            focusPolicy: Qt.WheelFocus
            Layout.preferredHeight: 60
            Layout.preferredWidth: parent.width
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            TextArea{
                id:  name_area
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.preferredHeight: parent.width
                Layout.preferredWidth: parent.width
                textFormat: Text.AutoText
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                placeholderText: qsTr("Введите название нового проекта")
                background: Rectangle{
                    anchors.fill: parent
                    radius: 5
                    opacity: 0.95
                    gradient: Gradient {
                        GradientStop { position: 0.00; color: "#ffffff"}
                        GradientStop { position: 1.00; color: "#E6E6FA"}
                    }
                }               
            }
        }

        Button{
            id: button
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
                implicitHeight: 40
                gradient: button.hovered ? hoveredGradient :
                          normalGradient
                radius: 5
            }

            onClicked: {
                pushanimation.start()
                if (name_area.text == ""){
                    errorPopup.text = "Пожалуйста, введите название нового проекта"
                    createPopup.start()
                }
                else{
                    checkNameProject(name_area.text)
                    name_area.text = ""     // очишаем окна ввода
                }
            }

            ScaleAnimator{
                id: pushanimation
                target: button
                from: 0.9
                to: 1.0
            }
        }
    }

    // Если пользователь не введёт название или введёт существующее, то отобразится уведомление на месте Lable
    // которое исчезнет через несколько секунд и пользователь вновь увидит описание Lable
    Label {
        id: errorPopup
        width: lable.width
        height: lable.height
        x: lable.x
        y: lable.y
        visible: false
        color: "#ffffff"
        lineHeight: 1.1
        wrapMode: Text.WordWrap
        font.capitalization: Font.AllUppercase
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        Layout.preferredWidth: lable.width
        Layout.preferredHeight: lable.height
        Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
        anchors.horizontalCenter: parent.horizontalCenter
        background: Rectangle{
            anchors.fill: parent
            color: "#1C1C1C"
        }
        NumberAnimation on visible{
            id: createPopup
            from: 1
            to: 1
            duration: 3000
            running: false
            onRunningChanged: {
                if (!running) {
                    console.log("Creating...")
                    detroyPopup.start()
                }
            }
        }
        NumberAnimation on opacity{
            id: detroyPopup
            from: 1
            to: 0
            duration: 2000
            running: false
            onRunningChanged: {
                if (!running) {
                    console.log("Destroying...")
                    errorPopup.visible = false
                    errorPopup.opacity = 1
                }
            }
        }
    }
}
