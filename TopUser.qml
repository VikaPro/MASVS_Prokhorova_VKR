import QtQuick 2.12
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3
import QtGraphicalEffects 1.12


Rectangle{
    id:header
    height: 50

    gradient: Gradient {
        GradientStop {
            position: 0.00;
            color: "#99E1FF"
        }
        GradientStop {
            position: 1.00;
            color: "#57ADD1"
        }
    }

    Label {
        text: "ПОЛЬЗОВАТЕЛЬСКАЯ ОЦЕНКА"
        font.pointSize: 12
        wrapMode: Text.WordWrap
        anchors.fill: parent
        font.weight: Font.DemiBold
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.capitalization: Font.AllUppercase
    }

    // ОБЯЗАТЕЛЬНО СДЕЛАТЬ ПОДСКАЗКУ ДЛЯ КНОПКИ


    // кнопка "Домой"
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
            // и не увеличиваем счётчик! потому что пользователь не дал результат
            incompleteChecks(prog_bar.value)
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
