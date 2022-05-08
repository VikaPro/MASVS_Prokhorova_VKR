import QtQuick 2.12
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3

Rectangle{
    id:header
    color: "#80CBC4"
    height: 50

    Label {
        text: varItemEasy.aTextEasy
        font.pointSize: 12
        wrapMode: Text.WordWrap
        anchors.fill: parent
        Material.foreground: "#313031"
        font.weight: Font.DemiBold
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
}
