import QtQuick 2.0

import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3

Page {

    visible: false
    anchors.fill: parent

    header: Rectangle{
        id:header
        color: "#80CBC4"
        height: 50

        // потом изменить и сделать с подсказками и всем прочим
        Button{
            id:undo_tab
            width: 40
            height: 40
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 20


            background: Image {
                anchors.fill: parent
                source: "qrc:/image/image/undo.png"
            }

            ScaleAnimator{
                id: push_undo
                target: undo_tab
                from: 0.7
                to: 1.0
                duration: 1
                running: false
            }
        }

        Label {
            text: "ПОЛЬЗОВАТЕЛЬСКАЯ ОЦЕНКА"
            font.pointSize: 12
            wrapMode: Text.WordWrap
            anchors.fill: parent
            Material.foreground: "#313031"
            font.weight: Font.DemiBold
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Button{
            id:home_tab
            width: 40
            height: 40
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 20


            background: Image {
                anchors.fill: parent
                source: "qrc:/image/image/end.png"
            }

            ScaleAnimator{
                id: push_home
                target: home_tab
                from: 0.7
                to: 1.0
                duration: 120
                running: false
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
            text: "Требование 1.6"
            font.bold: true
            wrapMode: Text.WordWrap
            Layout.alignment: Qt.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.preferredWidth: parent.width
        }

        Label {
            id: description_label
            text: "Сформирована модель угроз для мобильного приложения и связанных с ним удаленных сервисов, которая идентифицирует потенциальные угрозы и необходимые контрмеры"
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
            }

            // Добавить события для кнопки
            Button{
                text: "НЕ ВЫПОЛНЕНО"
                Layout.alignment: Qt.AlignHCenter
                Material.background: Material.Red
                Material.foreground: "#313031"
            }

            // Добавить события для кнопки
            Button{
                text: "ПРОПУСТИТЬ"
                Layout.alignment: Qt.AlignHCenter
                Material.background: Material.Yellow
                Material.foreground: "#313031"
            }

        }

        Label {
            id: result_label
            text: "Стандарт MASVS предлагает свой подход к моделированию угроз, описанный в документе OWASP Threat modelling - https://owasp.org/www-community/Application_Threat_Modeling
Для соответствия данному требованию Вы можете воспользоваться отечественным аналогом - проектом методического документа ФСТЭК «Методика моделирования угроз безопасности информации» от 2020г."
            wrapMode: Text.WordWrap
            Layout.alignment: Qt.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.preferredWidth: parent.width
        }
    }
}
