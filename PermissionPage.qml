import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3

Page {

    visible: false
    anchors.fill: parent

    header: TopEasy{

        Item {
            id: varItemEasy
            property string aTextEasy: "РАЗРЕШЕНИЯ АНАЛИЗИРУЕМОГО ПРИЛОЖЕНИЯ"
        }
    }

    ColumnLayout{
        anchors.fill: parent
        spacing: 30

        Label {
            text: "Приложение запрашивает следующие разрешения. Пожалуйста, оцените самостоятельно, является ли данный набор минимально необходимым. Если хотя бы одно из опасных разрешений логически не подходит, то вы должны отметить требование как невыполненное"
            wrapMode: Text.WordWrap
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.preferredWidth: 0.9 * parent.width
            //Layout.fillHeight: true
            Layout.topMargin: 20
        }

        ListView{
            id: listView
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillHeight: true
            Layout.preferredWidth: 0.9 * parent.width
            spacing: 20
            model: _permission //модель со всеми существующими разрешениями

            //карточка с параметрами
            delegate: Rectangle{
                width: parent.width
                height: 40
                radius: 5
                gradient: Gradient {
                    GradientStop {

                        position: 0.00;
                        color:
                            if(level == "normal"){
                                color: "#80CBC4"
                            }
                            else{
                                color: "#E15BA0"
                            }
                    }
                    GradientStop {
                        position: 1.00;
                        color: "#000000"
                    }
                }

                GridLayout{
                    anchors.fill: parent
                    columns: 4
                    rows: 1

                    Label{  // название разрешения
                        text: name
                        Layout.column: 0
                        wrapMode: Text.WordWrap
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.preferredWidth: 0.3 * parent.width
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    }

                    Label{  // его уровень
                        text: level
                        Layout.column: 1
                        wrapMode: Text.WordWrap
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.preferredWidth: 0.15 * parent.width
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    }
                }
            }
        }

        RowLayout{
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.bottomMargin: 20
            spacing: 20

            // Добавить события для кнопки
            Button{
                id: but1
                text: "ВЫПОЛНЕНО"
                Layout.alignment: Qt.AlignHCenter
                Material.background: Material.Green
                Material.foreground: "#313031"
                onClicked: {
                    resultMinPermissions(but1.text);
                    permissionPage.visible = false;
                    pageAutoTest.visible = true;
                }
            }

            // Добавить события для кнопки
            Button{
                id: but2
                text: "НЕ ВЫПОЛНЕНО"
                Layout.alignment: Qt.AlignHCenter
                Material.background: Material.Red
                Material.foreground: "#313031"
                onClicked: {
                    resultMinPermissions(but2.text);
                    permissionPage.visible = false;
                    pageAutoTest.visible = true;
                }
            }
        }
    }
}
