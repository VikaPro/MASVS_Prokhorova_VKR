import QtQuick 2.12
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3

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
        text: varItemEasy.aTextEasy
        font.pointSize: 12
        wrapMode: Text.WordWrap
        anchors.fill: parent
        font.weight: Font.DemiBold
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }
}
