import QtQuick 2.0

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
            result_label.text = result;
            prog_bar.value++;           // после каждого теста значение увеличивается
        }

        onEndAutoTest:{     // после прохождения всех автоматических тестирований появляется кнопка для продолжения
            next_button.visible = true
        }

        onCheckPermission:{     // разрешения необходимо проверить пользователем
            pageAutoTest.visible = false
            permissionPage.visible = true
        }
    }


    visible: false
    anchors.fill: parent

    header: Rectangle{
        id:header
        color: "#80CBC4"
        height: 50

        Label {
            text: "АВТОМАТИЗИРОВАННЫЕ ТЕСТЫ ПО СТАНДАРТУ MASVS"
            font.pointSize: 12
            wrapMode: Text.WordWrap
            anchors.fill: parent
            Material.foreground: "#313031"
            font.weight: Font.DemiBold
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
    }


    ColumnLayout{
        width: 0.8 * parent.width
        anchors.centerIn: parent
        spacing: 40

        Label {
            id: number_label
            font.bold: true
            wrapMode: Text.WordWrap
            Layout.alignment: Qt.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.preferredWidth: parent.width
        }

        Label {
            id: description_label
            text: "Информация о статусе тестирования будет отображаться здесь"
            wrapMode: Text.WordWrap
            Layout.alignment: Qt.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.preferredWidth: parent.width
        }

        Label {
            id: result_label
            font.bold: true
            wrapMode: Text.WordWrap
            Layout.alignment: Qt.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.preferredWidth: parent.width
        }

        RowLayout{
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            ProgressBar{
                id: prog_bar
                value: 0
                from: 0
                to: 24
                Material.accent: Material.Teal
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.preferredWidth: 0.6 * pageAutoTest.width
                Layout.preferredHeight:15

                background: Rectangle {           //это фоновая строка до прогрузки
                    color: "#ffffff"
                    opacity: 0.4
                    radius: 5
                }

                Rectangle {     //показывает,сколько уже воспроизвелось
                    width: prog_bar.visualPosition * parent.width
                    height: 15
                    color: "#80CBC4"
                    radius: 5
                }
            }

            Label {
                text: prog_bar.value + "/" + prog_bar.to
                font.pointSize: 10
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.preferredWidth: 0.1 * pageAutoTest.width
                Layout.preferredHeight: 15
            }
        }

        // Добавить события для кнопки
        Button{
            id: next_button
            visible: false
            text: "ВСЁ"
            Layout.alignment: Qt.AlignHCenter
            onClicked: {
                pageAutoTest.visible = false
                pageUserTest.visible = true
            }
        }
    }
}
