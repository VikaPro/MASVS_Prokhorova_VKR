import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3

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
            property string aText: "ВЫБОР УРОВНЯ БЕЗОПАСНОСТИ ПРИЛОЖЕНИЯ"
            property var aPageFalse: levelSec
            property var aPageTrue: onlyApk
            property string aLevel: ""  // переменная для выбранного уровня безопасности
        }
    }

    ColumnLayout{
        width: 0.9 * parent.width
        anchors.centerIn: parent
        spacing: 40

        Label {
            id: info_level
            text: qsTr("В стандарте MASVS представлены четыре возможные комбинации проерки приложения. Для получения дополнительной информации выберите один из уровней проверки, нажав на соответствующую кнопку")
            wrapMode: Text.WordWrap
            Layout.alignment: Qt.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.preferredWidth: parent.width
        }

        RowLayout{
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: true
            spacing: 40

            Button{
                text: "L1"
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                onClicked: {
                    levSec.text = "Вы выбрали для тестирования приложения базовый уровень L1";
                    info_level.text = "Описание уровня. L1";
                    varItem.aLevel = "L1";
                }
            }

            Button{
                text: "L2"
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                onClicked: {
                    levSec.text = "Вы выбрали для тестирования приложения усиленный уровень L2"
                    info_level.text = "Описание уровня. L2"
                    varItem.aLevel = "L2"
                }
            }

            Button{
                text: "L1 + R"
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                onClicked: {
                    levSec.text = "Вы выбрали для тестирования приложения комбинацию базового уровня L1 и дополнение R"
                    info_level.text = "Описание уровня. L1 + R"
                    varItem.aLevel = "L1R"
                }
            }

            Button{
                text: "L2 + R"
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter
                onClicked: {
                    levSec.text = "Вы выбрали для тестирования приложения комбинацию усиленного уровня L2 и дополнение R"
                    info_level.text = "Описание уровня. L2 + R"
                    varItem.aLevel = "L2R"
                }
            }
        }

        Label{
            id: levSec
            wrapMode: Text.WordWrap
            Layout.alignment: Qt.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
        }

        Button{
            text: "Начать тестирование!"
            Layout.alignment: Qt.AlignHCenter
            onClicked: {
                if(levSec.text != ""){
                    levelSec.visible = false
                    pageAutoTest.visible = true
                    autoTest(varItem.aLevel);
                }
                else{
                    levSec.text = "Пожалуйста, выберите желаемый уровень безопасности мобильного приложения."
                }
            }
        }
    }
}
