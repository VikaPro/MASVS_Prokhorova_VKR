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

    // Зелёный цвет для результата ВЫПОЛНЕНО
    // тёмный зелёный цвет
    Gradient {
        id: green_normal_Gradient
        GradientStop { position: 0.0; color: "#57FF88" }
        GradientStop { position: 1.0; color: "#1DAF49" }
    }
    // светлый зелёный цвет
    Gradient {
        id: green_hovered_Gradient
        GradientStop { position: 0.0; color: "#B8FFCD" }
        GradientStop { position: 1.0; color: "#57D17A" }
    }

    // Красный цвет для результата НЕ ВЫПОЛНЕНО
    // тёмный красный цвет
    Gradient {
        id: red_normal_Gradient
        GradientStop { position: 0.0; color: "#FF5793" }
        GradientStop { position: 1.0; color: "#AF1D4E" }
    }
    // светлый красный цвет
    Gradient {
        id: red_hovered_Gradient
        GradientStop { position: 0.0; color: "#FFB8D0" }
        GradientStop { position: 1.0; color: "#D15781" }
    }

    ColumnLayout{
        anchors.fill: parent
        spacing: 5

        Label {
            color: "#ffffff"
            font.pointSize: 11
            Layout.topMargin: 20
            text: "Приложение запрашивает следующие разрешения. Пожалуйста, оцените самостоятельно, является ли данный набор минимально необходимым. Если хотя бы одно из опасных разрешений логически не подходит, то вы должны отметить требование как невыполненное"
            lineHeight: 1.1
            wrapMode: Text.WordWrap
            //font.weight: Font.DemiBold
            //font.capitalization: Font.AllUppercase
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.preferredWidth: 0.9 * parent.width
            Layout.preferredHeight: 0.3 * parent.height
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        ListView{
            id: listView
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillHeight: true
            Layout.preferredWidth: 0.9 * parent.width
            spacing: 2
            clip: true
            model: _permission //модель со всеми существующими разрешениями

            //карточка с параметрами
            delegate: Rectangle{
                width: parent.width
                height: 40
                radius: 5
                opacity: 0.9
                gradient: Gradient {
                    GradientStop {
                        position: 0.00;
                        color: "#ffffff"
                    }
                    GradientStop {
                        position: 1.00;
                        color:
                            if(level == "обычное"){
                                color: "#B5E0B2"
                            }
                            else{
                                color: "#E0B2BA"
                            }
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

        // две кнопки с выбором
        RowLayout{
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 0.2 * parent.height
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            spacing: 20

            // Кнопка с присвоением требованию значения ВЫПОЛНЕНО
            Button{
                id: but_yes
                text: "ВЫПОЛНЕНО"
                Layout.preferredWidth: 110
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter

                background: Rectangle {
                    radius: 5
                    implicitHeight: 40
                    gradient: but_yes.hovered ? green_hovered_Gradient :
                                                green_normal_Gradient
                }

                // результат можно менять только у пользовательских проверок
                onClicked: {
                    pushanimation1.start()
                    resultMinPermissions(but_yes.text);
                    permissionPage.visible = false;
                    pageAutoTest.visible = true;
                }

                ScaleAnimator{
                    id: pushanimation1
                    target: but_yes
                    from: 0.9
                    to: 1.0
                }
            }

            // Кнопка с присвоением требованию значения НЕ ВЫПОЛНЕНО
            Button{
                id: but_not
                text: "НЕ ВЫПОЛНЕНО"
                Layout.preferredWidth: 120
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter

                background: Rectangle {
                    radius: 5
                    implicitHeight: 40
                    gradient: but_not.hovered ? red_hovered_Gradient :
                                                red_normal_Gradient
                }

                // результат можно менять только у пользовательских проверок
                onClicked: {
                    pushanimation2.start()
                    resultMinPermissions("НЕ_ВЫПОЛНЕНО");
                    permissionPage.visible = false;
                    pageAutoTest.visible = true;
                }

                ScaleAnimator{
                    id: pushanimation2
                    target: but_not
                    from: 0.9
                    to: 1.0
                }
            }
        }
    }
}
