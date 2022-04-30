import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

Page {

    Connections {
        target: _select     // все эти сигналы находятся в selectproject

        // необходимо для возвращения со страницы с уровнем безопасности к загрузке файлов
        onSelectLevel:{
            if (typeFile == "apk"){
                varItem.aPageTrue = onlyApk
            }
            else if (typeFile == "source"){
                varItem.aPageTrue = apkAndCode
            }
        }
    }

    visible: false
    anchors.fill: parent

    header: Top{
        Item {
            id: varItem
            property string aText: "Выбор уровня безопасности"
            property var aPageFalse: levelSec
            property var aPageTrue: onlyApk
        }
    }

    GridLayout{
        anchors.fill: parent

        ColumnLayout{
            Layout.alignment: Qt.AlignHCenter
            spacing: 40

            RowLayout{
                Layout.alignment: Qt.AlignHCenter
                spacing: 40

                ColumnLayout{
                    id: l1
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 40

                    Label {
                        text: qsTr("Описание уровня.")
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Button{
                        text: "L1"
                        Layout.alignment: Qt.AlignHCenter
                        onClicked: {
                            levSec.text = "Вы выбрали для тестирования приложения базовый уровень L1"
                        }
                    }
                }

                ColumnLayout{
                    id: l2
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 40

                    Label {
                        text: qsTr("Описание уровня.")
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Button{
                        text: "L2"
                        Layout.alignment: Qt.AlignHCenter
                        onClicked: {
                            levSec.text = "Вы выбрали для тестирования приложения усиленный уровень L2"
                        }
                    }
                }

                ColumnLayout{
                    id: l1r
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 40

                    Label {
                        text: qsTr("Описание уровня.")
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Button{
                        text: "L1 + R"
                        Layout.alignment: Qt.AlignHCenter
                        onClicked: {
                            levSec.text = "Вы выбрали для тестирования приложения комбинацию базового уровня L1 и дополнение R"
                        }
                    }
                }

                ColumnLayout{
                    id: l2r
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 40

                    Label {
                        text: qsTr("Описание уровня.")
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Button{
                        text: "L2 + R"
                        Layout.alignment: Qt.AlignHCenter
                        onClicked: {
                            levSec.text = "Вы выбрали для тестирования приложения комбинацию усиленного уровня L2 и дополнение R"
                        }
                    }
                }
            }

            Label{
                id: levSec
                Layout.alignment: Qt.AlignHCenter
            }

            Button{
                text: "Начать тестирование!"
                Layout.alignment: Qt.AlignHCenter
                onClicked: {

                    if(levSec.text != ""){
                        levelSec.visible = false
                    }

                    else{
                        levSec.text = "ВЫБЕРИТЕ УРОВЕНЬ!!!"
                    }
                }
            }
        }
    }
}
