import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3

Page {
    visible: false
    anchors.fill: parent

    header: Top{
        Item {
            id: varItem
            property string aText: "ЗАГРУЗКА ВХОДНЫХ ДАННЫХ ДЛЯ АНАЛИЗА"
            property var aPageFalse: downloadWindow
            property var aPageTrue: nameProject
        }
    }

    ColumnLayout{
        width: 0.9 * parent.width
        height: parent.height
        anchors.centerIn: parent
        spacing: 0.1 * parent.height


        Label {
            id: label
            color: "#ffffff"
            lineHeight: 1.1
            font.pointSize: 12
            text: "Выбор типа входных данных зависит от имеющегося у Вас набора файлов приложения. Наведите на интересующую карточку для получения дополнительной информации"
            wrapMode: Text.WordWrap
            //font.weight: Font.DemiBold
            //font.capitalization: Font.AllUppercase
            verticalAlignment: Text.AlignBottom
            horizontalAlignment: Text.AlignHCenter
            Layout.preferredWidth: 0.9 * parent.width
            Layout.preferredHeight: 0.35 * parent.height
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }


        RowLayout{
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 0.55 * parent.height
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            // Большая кнопка "ТОЛЬКО ФАЙЛ APK"
            MouseArea{
                Layout.preferredWidth: 0.42 * parent.width
                Layout.preferredHeight: 0.7 * parent.height
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

                // фон для карточки
                Rectangle{
                    id: card_only_apk
                    anchors.fill: parent
                    radius: 10
                    gradient: Gradient {
                        GradientStop {
                            id: grad1
                            position: 0.00;
                            color: "#99E1FF"
                        }
                        GradientStop {
                            id: grad2
                            position: 1.00;
                            color: "#57ADD1"
                        }
                    }
                }

                ColumnLayout{
                    anchors.fill: parent

                    // Картинка файла APK
                    Image {
                        id: image_card_only_apk
                        Layout.maximumWidth: 240
                        Layout.maximumHeight: 240
                        Layout.preferredWidth: image_card_only_apk.height
                        Layout.preferredHeight:  0.5 * parent.height
                        Layout.topMargin: 0.05 * parent.height
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        source: "qrc:/image/image/only_apk.png"
                    }

                    Label {
                        text: "ТОЛЬКО ФАЙЛ APK"
                        font.pointSize: 10
                        font.weight: Font.DemiBold
                        wrapMode: Text.WordWrap
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.bottomMargin: 0.05 * parent.height
                        Layout.preferredWidth: 0.9 * parent.width
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    }
                }

                // изменение цвета карточки при наведении
                hoverEnabled: true
                onEntered: {
                    grad1.color = "#D7F3FE"
                    grad2.color = "#99E1FF"
                    label.text = "Подходит для тестированияя мобильного приложения третьим лицом, не имеющим доступа к исходному коду. Данный тип позволяет провести поверхностный анализ, но не гарантирует достоверность оценки"
                }
                onExited: {
                    grad1.color = "#99E1FF"
                    grad2.color = "#57ADD1"
                    label.text = "Выбор типа входных данных зависит от имеющегося у Вас набора файлов приложения. Наведите на интересующую карточку для получения дополнительной информации"
                }

                onClicked: {
                    downloadWindow.visible = false
                    onlyApk.visible = true
                }
            }


            // Большая кнопка "ФАЙЛ APK + ИСХОДНЫЙ КОД"
            MouseArea{
                Layout.preferredWidth: 0.42 * parent.width
                Layout.preferredHeight: 0.7 * parent.height
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

                // фон для карточки
                Rectangle{
                    id: card_apk_src
                    anchors.fill: parent
                    radius: 10
                    gradient: Gradient {
                        GradientStop {
                            id: grad1_all
                            position: 0.00;
                            color: "#99E1FF"
                        }
                        GradientStop {
                            id: grad2_all
                            position: 1.00;
                            color: "#57ADD1"
                        }
                    }
                }

                ColumnLayout{
                    anchors.fill: parent

                    // Картинка нескольких файлов
                    Image {
                        id: image_apk_src
                        Layout.maximumWidth: 240
                        Layout.maximumHeight: 240
                        Layout.preferredWidth: image_apk_src.height
                        Layout.preferredHeight:  0.5 * parent.height
                        Layout.topMargin: 0.05 * parent.height
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        source: "qrc:/image/image/apk_src.png"
                    }

                    Label {
                        text: "APK + ИСХОДНЫЙ КОД"
                        font.pointSize: 10
                        font.weight: Font.DemiBold
                        wrapMode: Text.WordWrap
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.bottomMargin: 0.05 * parent.height
                        Layout.preferredWidth: 0.9 * parent.width
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    }
                }

                // изменение цвета карточки при наведении
                hoverEnabled: true
                onEntered: {
                    grad1_all.color = "#D7F3FE"
                    grad2_all.color = "#99E1FF"
                    label.text = "Подходит для тестирования разроботчикам или владельцам мобильных приложений, а также для анализа open source решений. При выборе данного типа необходимо загрузить: *.apk файл, каталог Android проекта и исходный код"

                }
                onExited: {
                    grad1_all.color = "#99E1FF"
                    grad2_all.color = "#57ADD1"
                    label.text = "Выбор типа входных данных зависит от имеющегося у Вас набора файлов приложения. Наведите на интересующую карточку для получения дополнительной информации"

                }

                onClicked: {
                    downloadWindow.visible = false
                    apkAndCode.visible = true
                }
            }
        }
    }
}
