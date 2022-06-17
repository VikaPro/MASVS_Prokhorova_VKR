import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3
import QtGraphicalEffects 1.12

Page {
    anchors.fill: parent

    header: TopEasy{
        Item {
            id: varItemEasy
            property string aTextEasy: "ГЛАВНОЕ ОКНО ПРОГРАММЫ - ВЫБОР ПРОЕКТА"
        }
    }


    ColumnLayout{
        width: 0.9 * parent.width
        height: parent.height
        anchors.centerIn: parent
        spacing: 0.1 * parent.height

        Label {
            color: "#ffffff"
            font.pointSize: 12
            text: "Данный программный модуль предназначен для оценки соответствия безопасности мобильного приложения под Android согласно требованиям стандарта MASVS - The Mobile Application Security Verification Standard"
            lineHeight: 1.1
            wrapMode: Text.WordWrap
            //font.weight: Font.DemiBold
            //font.capitalization: Font.AllUppercase
            verticalAlignment: Text.AlignBottom
            horizontalAlignment: Text.AlignHCenter
            Layout.preferredWidth: 0.9 * parent.width
            Layout.preferredHeight: 0.35 * parent.height
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        RowLayout{  
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 0.55 * parent.height
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            // Большая кнопка "Протестировать новое приложение"
            MouseArea{
                id:create_tab
                Layout.preferredWidth: 0.42 * parent.width
                Layout.preferredHeight: 0.7 * parent.height
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

                // фон для карточки
                Rectangle{
                    id: card_create
                    anchors.fill: parent
                    radius: 10
                    gradient: Gradient {
                        GradientStop {
                            id: grad1
                            position: 0.00;
                            color: "#99E1FF"
                        }
                        GradientStop {
                            id: grad2
                            position: 1.00;
                            color: "#57ADD1"
                        }
                    }
                }

                ColumnLayout{
                    anchors.fill: parent

                    // Картинка файла с ручкой
                    Image {
                        id: image_create_project
                        Layout.maximumWidth: 256
                        Layout.maximumHeight: 256
                        Layout.preferredWidth: image_create_project.height
                        Layout.preferredHeight:  0.5 * parent.height
                        Layout.topMargin: 0.05 * parent.height
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        source: "qrc:/image/image/new_project.png"
                    }

                    Label {
                        text: "ПРОТЕСТИРОВАТЬ НОВОЕ ПРИЛОЖЕНИЕ"
                        font.pointSize: 10
                        font.weight: Font.DemiBold
                        wrapMode: Text.WordWrap
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.bottomMargin: 0.05 * parent.height
                        Layout.preferredWidth: 0.9 * parent.width
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                    }
                }

                // изменение цвета карточки при наведении
                hoverEnabled: true
                onEntered: {
                    grad1.color = "#D7F3FE"
                    grad2.color = "#99E1FF"
                }
                onExited: {
                    grad1.color = "#99E1FF"
                    grad2.color = "#57ADD1"
                }

                onClicked: {
                    selectProject.visible = false
                    nameProject.visible = true

                }
            }


            // Большая кнопка "Открыть существующий проект"
            MouseArea{
                id: all_tab
                Layout.preferredWidth: 0.42 * parent.width
                Layout.preferredHeight: 0.7 * parent.height
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

                // фон для карточки
                Rectangle{
                    id: card_all
                    anchors.fill: parent
                    radius: 10
                    gradient: Gradient {
                        GradientStop {
                            id: grad1_all
                            position: 0.00;
                            color: "#99E1FF"
                        }
                        GradientStop {
                            id: grad2_all
                            position: 1.00;
                            color: "#57ADD1"
                        }
                    }
                }

                ColumnLayout{
                    anchors.fill: parent

                    // Картинка файла со списком
                    Image {
                        id: image_all_project
                        Layout.maximumWidth: 256
                        Layout.maximumHeight: 256
                        Layout.preferredWidth: image_all_project.height
                        Layout.preferredHeight:  0.5 * parent.height
                        Layout.topMargin: 0.05 * parent.height
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        source: "qrc:/image/image/list_project.png"
                    }

                    Label {
                        text: "ОТКРЫТЬ СУЩЕСТВУЮЩИЙ ПРОЕКТ"
                        font.pointSize: 10
                        font.weight: Font.DemiBold
                        wrapMode: Text.WordWrap
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.bottomMargin: 0.05 * parent.height
                        Layout.preferredWidth: 0.9 * parent.width
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                    }
                }

                // изменение цвета карточки при наведении
                hoverEnabled: true
                onEntered: {
                    grad1_all.color = "#D7F3FE"
                    grad2_all.color = "#99E1FF"
                }
                onExited: {
                    grad1_all.color = "#99E1FF"
                    grad2_all.color = "#57ADD1"
                }

                onClicked: {
                    setListProject()
                    selectProject.visible = false
                    allProjects.visible = true
                }
            }
        }
    }
}
