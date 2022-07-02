import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12
import QtQuick.Controls.Material 2.3

Page {

    Connections {
        target: _select     // все эти сигналы находятся в selectproject

        onSendPercent:{     // узнаем статистику соответствия в процентах
            varItemEasy.aTextEasy = "Статистика по проекту: " + name;
            /*if(percent < 50){
                percent_label.color = "#D7044B"   // красный цвет
            }
            else if(percent < 75){
                percent_label.color = "#FFA812"   // жёлтый цвет
            }
            else{
                percent_label.color = "#00BD39"   // зелёный цвет
            }*/
            percent_label.text = result + "%"
            total_yes_label.text = yesP + "/" + col + " требований ВЫПОЛНЕНО"
            total_not_label.text = notP + "/" + col + " требований НЕ ВЫПОЛНЕНО"
            total_unknow_label.text = unknowP + "/" + col + " требований НЕИЗВЕСТНО"
        }
    }

    visible: false
    anchors.fill: parent

    header: TopEasy{
        Item {
            id: varItemEasy
            property string aTextEasy: ""
        }
    }

    ColumnLayout{
        width: 0.8 * parent.width
        height: parent.height
        anchors.centerIn: parent

        Rectangle{
            color: "#ffffff"
            opacity: 0.9
            radius: 5
            Layout.topMargin: 20
            Layout.preferredHeight: 0.7 * parent.height
            Layout.preferredWidth: parent.width
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            ColumnLayout{
                width: 0.9 * parent.width
                height: 0.9 * parent.height
                anchors.centerIn: parent

                // Вступиельное предложение
                Label {
                    text: "Ваше приложение соответствует требованиям стандарта MASVS на:"
                    lineHeight: 1.1
                    font.pointSize: 12
                    wrapMode: Text.WordWrap
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 0.18 * parent.height
                }

                Label {
                    id: percent_label
                    font.pointSize: 50
                    font.bold: true
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 0.36 * parent.height
                }

                Label {
                    id: total_yes_label
                    font.pointSize: 12
                    font.bold: true
                    color: "#1DAF49"   // зелёный цвет
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 0.1 * parent.height
                }
                Label {
                    id: total_not_label
                    font.pointSize: 12
                    font.bold: true
                    color: "#AF1D4E"   // красный цвет
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 0.1 * parent.height
                }
                Label {
                    id: total_unknow_label
                    font.pointSize: 12
                    font.bold: true
                    color: "#ED9702"   // жёлтый цвет
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 0.1 * parent.height
                }
            }
        }

        Button{
            id: but_confirm
            text: "Вернуться к отчёту"
            Layout.bottomMargin: 20
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
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
                gradient: but_confirm.hovered ? hoveredGradient :
                                                normalGradient
                radius: 5
            }

            onClicked: {
                pushanimation.start()
                percentPage.visible = false
                readReport.visible = true
            }

            ScaleAnimator{
                id: pushanimation
                target: but_confirm
                from: 0.9
                to: 1.0
            }
        }
    }
}

