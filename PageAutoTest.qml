import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3

Page {

    Connections {
        target: _auto     // все эти сигналы находятся в autotesting

        onColAutoTest:{     // узнаем суммарное количество автотестов
            prog_bar.to = col;
        }

        onEndOneTest:{     // после завершения каждого теста выводим результат на экран
            number_label.text = "Требование MASVS № " + number;
            description_label.text = description;
            if (result == "ВЫПОЛНЕНО"){
                result_label.text = "ВЫПОЛНЕНО"
                result_label.color = "#02BB3D";

            }
            else{
                result_label.color = "#BB0233";
                result_label.text = "НЕ ВЫПОЛНЕНО"
            }
            prog_bar.value++;           // после каждого теста значение увеличивается
        }

        onEndAutoTest:{     // после прохождения всех автоматических тестирований появляется кнопка для продолжения
            but_confirm.enabled = true
        }

        onCheckPermission:{     // разрешения необходимо проверить пользователем
            pageAutoTest.visible = false
            permissionPage.visible = true
        }
    }

    visible: false
    anchors.fill: parent

    header: TopEasy{
        Item {
            id: varItemEasy
            property string aTextEasy: "АВТОМАТИЗИРОВАННЫЕ ТЕСТЫ ПО СТАНДАРТУ MASVS"
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
            Layout.preferredHeight: 0.6 * parent.height
            Layout.preferredWidth: parent.width
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            ColumnLayout{
                width: 0.9 * parent.width
                height: 0.9 * parent.height
                anchors.centerIn: parent

                Label {
                    id: number_label
                    font.bold: true
                    lineHeight: 1.1
                    font.pointSize: 12
                    wrapMode: Text.WordWrap
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.preferredWidth: parent.width
                }

                Label {
                    id: description_label
                    lineHeight: 1.1
                    font.pointSize: 10
                    text: "Информация о статусе тестирования будет отображаться здесь"
                    wrapMode: Text.WordWrap
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.preferredWidth: parent.width
                }

                Label {
                    id: result_label
                    lineHeight: 1.1
                    font.pointSize: 12
                    font.bold: true
                    color: "#02BB3D"   // по умолчанию поставим зелёный цвет - выполнено
                    wrapMode: Text.WordWrap
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.preferredWidth: parent.width
                }
            }
        }

        RowLayout{
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 0.1 * parent.height
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

            ProgressBar{
                id: prog_bar
                value: 0
                from: 0
                to: 24

                Layout.alignment: Qt.AlignHCenter| Qt.AlignTop
                Layout.fillWidth: true
                Layout.preferredHeight: 15

                background: Rectangle {           //это фоновая строка до первого теста
                    color: "#ffffff"
                    opacity: 0.6
                    radius: 5
                }

                Rectangle {     //показывает, сколько требований уже прошло
                    width: prog_bar.visualPosition * parent.width
                    height: 15
                    color: "#53BDE9"
                    radius: 5
                }
            }

            Label {
                text: prog_bar.value + "/" + prog_bar.to
                font.pointSize: 10
                color: "#ffffff"
                Layout.alignment: Qt.AlignRight | Qt.AlignTop
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.preferredHeight: 15
            }
        }

        Button{
            id: but_confirm
            enabled: false
            text: "Продолжить тестирование"
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
                Gradient {
                    id: disabledGradient
                    GradientStop { position: 0.0; color: "#E2EDF3" }
                    GradientStop { position: 1.0; color: "#B0BFC4" }
                }
                implicitHeight: 40
                gradient: but_confirm.hovered ? hoveredGradient :
                          but_confirm.enabled ? normalGradient :
                          disabledGradient
                radius: 5
            }

            onClicked: {
                pushanimation.start()
                pageAutoTest.visible = false
                pageUserTest.visible = true
                userTest();    // запускаем функцию с ручными проверками
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
