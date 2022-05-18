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
            color: "#80CBC4"
        }
        GradientStop {
            position: 1.00;
            color: "#313031"
        }
    }

    // кнопка "Назад"
    MouseArea{
        id:undo_tab
        width: 40
        height: 40
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: 20

        // изменение цвета иконки при наведении
        hoverEnabled: true
        onEntered: {
            image_undo.source = "qrc:/image/image/undo_light.png"
        }
        onExited: {
            image_undo.source = "qrc:/image/image/undo.png"
        }

        // вдавливание кнопки не делаем, т.к. не успевает отобразиться
        onClicked: {
            varItem.aPageFalse.visible = false
            varItem.aPageTrue.visible = true
        }

        Image {
            id: image_undo
            anchors.fill: parent
            source: "qrc:/image/image/undo.png"
        }

        DropShadow {
            anchors.fill: image_undo
            horizontalOffset: 3
            verticalOffset: 3
            radius: 8.0
            samples: 17
            color: "#80000000"  // чёрный прозрачный
            source: image_undo
        }
    }


    Label {
        text: varItem.aText
        font.pointSize: 12
        wrapMode: Text.WordWrap
        anchors.fill: parent
        font.weight: Font.DemiBold
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    // кнопка "Домой"
    MouseArea{
        id: home_tab
        width: 40
        height: 40
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: 20

        // изменение цвета иконки при наведении
        hoverEnabled: true
        onEntered: {
            image_home.source = "qrc:/image/image/home_light.png"
        }
        onExited: {
            image_home.source = "qrc:/image/image/home.png"
        }

        // вдавливание кнопки не делаем, т.к. не успевает отобразиться
        onClicked: {
            varItem.aPageFalse.visible = false
            selectProject.visible = true
        }

        Image {
            id: image_home
            anchors.fill: parent
            source: "qrc:/image/image/home.png"
        }

        DropShadow {
            anchors.fill: image_home
            horizontalOffset: 3
            verticalOffset: 3
            radius: 8.0
            samples: 17
            color: "#80000000"  // чёрный прозрачный
            source: image_home
        }
    }
}

