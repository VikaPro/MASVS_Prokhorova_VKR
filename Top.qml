import QtQuick 2.12
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3


Rectangle{
    id:header
    color: "#80CBC4"
    height: 50

    Button{
        id:undo_tab
        width: 40
        height: 40
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: 20

        onClicked: {
            push_undo.start()
            varItem.aPageFalse.visible = false
            varItem.aPageTrue.visible = true
        }

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
        text: varItem.aText
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

        onClicked: {
            push_home.start()
            varItem.aPageFalse.visible = false
            selectProject.visible = true
        }

        background: Image {
            anchors.fill: parent
            source: "qrc:/image/image/home.png"
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

