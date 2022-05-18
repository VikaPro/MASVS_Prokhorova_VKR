import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3
import QtGraphicalEffects 1.12

Page {

    Connections {
        target: _user    // все эти сигналы находятся в usertesting

        onColUserTest:{
            prog_bar.to = col;
        }
        onShowUserCard:{
            prog_bar.value = index + 1;
            number_label.text = number;
            description_label.text = description;
        }
    }

    visible: false
    anchors.fill: parent

    header: Rectangle{
        id:header
        height: 50

        gradient: Gradient {
            GradientStop {
                position: 0.00;
                color: "#80CBC4"
            }
            GradientStop {
                position: 1.00;
                color: "#313031"
            }
        }

        // ОБЯЗАТЕЛЬНО СДЕЛАТЬ ПОДСКАЗКУ ДЛЯ КНОПКИ
        Label {
            text: "ПОЛЬЗОВАТЕЛЬСКАЯ ОЦЕНКА"
            font.pointSize: 12
            wrapMode: Text.WordWrap
            anchors.fill: parent
            font.weight: Font.DemiBold
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        // кнопка "Конец"
        MouseArea{
            id: end_tab
            width: 40
            height: 40
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 20

            // изменение цвета иконки при наведении
            hoverEnabled: true
            onEntered: {
                image_end.source = "qrc:/image/image/end_light.png"
            }
            onExited: {
                image_end.source = "qrc:/image/image/end.png"
            }

            // вдавливание кнопки не делаем, т.к. не успевает отобразиться
            onClicked: {
                pageUserTest.visible = false
                // сообщаем программе, на каком требовании пользователь прервал проверки
                incompleteChecks(prog_bar.value)
                // решить, что тут будем отображать, сразу отчёт?
            }

            Image {
                id: image_end
                anchors.fill: parent
                source: "qrc:/image/image/end.png"
            }

            DropShadow {
                anchors.fill: image_end
                horizontalOffset: 3
                verticalOffset: 3
                radius: 8.0
                samples: 17
                color: "#80000000"  // чёрный прозрачный
                source: image_end
            }
        }
    }


    ColumnLayout{
        width: 0.9 * parent.width
        //Layout.preferredWidth: 0.9 * parent.width
        anchors.centerIn: parent
        //Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        spacing: 30

        Label {
            id: number_label
            //text: "Требование 1.6"
            font.bold: true
            wrapMode: Text.WordWrap
            Layout.alignment: Qt.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.preferredWidth: parent.width
        }

        Label {
            id: description_label
            //text: "Сформирована модель угроз для мобильного приложения и связанных с ним удаленных сервисов, которая идентифицирует потенциальные угрозы и необходимые контрмеры"
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
            spacing: 20

            // Добавить события для кнопки
            Button{
                text: "ВЫПОЛНЕНО"
                Layout.alignment: Qt.AlignHCenter
                Material.background: Material.Green
                Material.foreground: "#313031"
                onClicked: {
                    resultUser(number_label.text, description_label.text, "ВЫПОЛНЕНО", prog_bar.value)
                }
            }

            // Добавить события для кнопки
            Button{
                text: "НЕ ВЫПОЛНЕНО"
                Layout.alignment: Qt.AlignHCenter
                Material.background: Material.Red
                Material.foreground: "#313031"
                onClicked: {
                    resultUser(number_label.text, description_label.text, "НЕ ВЫПОЛНЕНО", prog_bar.value)
                }
            }

            // Добавить события для кнопки
            Button{
                text: "ПРОПУСТИТЬ"
                Layout.alignment: Qt.AlignHCenter
                Material.background: Material.Yellow
                Material.foreground: "#313031"
                onClicked: {
                    resultUser(number_label.text, description_label.text, "НЕИЗВЕСТНО", prog_bar.value)
                }
            }

        }

        Label {
            id: result_label
            wrapMode: Text.WordWrap
            Layout.alignment: Qt.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.preferredWidth: parent.width
        }

        Label {
            id: note_label
            text: "Стандарт MASVS предлагает свой подход к моделированию угроз, описанный в документе OWASP Threat modelling - https://owasp.org/www-community/Application_Threat_Modeling
Для соответствия данному требованию Вы можете воспользоваться отечественным аналогом - проектом методического документа ФСТЭК «Методика моделирования угроз безопасности информации» от 2020г."
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
                Layout.preferredWidth: 0.6 * pageUserTest.width
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
                Layout.preferredWidth: 0.1 * pageUserTest.width
                Layout.preferredHeight: 15
            }
        }
    }
}
