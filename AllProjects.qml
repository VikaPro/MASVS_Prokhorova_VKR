import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3

Page {

    Connections {
        target: _select     // все эти сигналы находятся в selectproject

        onReadReport:{     // после нажатия на кнопку "отчёт" отобразится страница с конкретным отчётом
            allProjects.visible = false
            readReport.visible = true
        }
    }

    visible: false
    anchors.fill: parent

    header: Top{
        Item {
            id: varItem
            property string aText: "СПИСОК СУЩЕСТВУЮЩИХ ПРОЕКТОВ"
            property var aPageFalse: allProjects
            property var aPageTrue: selectProject
        }
    }

    ColumnLayout{
        anchors.fill: parent

        // список с карточками для всех проектов
        ListView{
            id: listView
            Layout.alignment: Qt.AlignHCenter
            Layout.fillHeight: true
            Layout.preferredWidth: 0.95 * parent.width
            Layout.bottomMargin: 10
            spacing: 4
            model: _projects // модель со всеми существующими проектами


            // Заголовок к списку с проектами
            headerPositioning: ListView.OverlayHeader
            header: Rectangle{
                width: parent.width
                height: 50
                anchors.horizontalCenter: parent.horizontalCenter
                color: "#1C1C1C"
                z: 2    // выводим на передний план

                GridLayout{
                    rows: 1
                    columns: 6
                    columnSpacing: 0
                    anchors.fill: parent

                    Label{  // название проекта
                        text: "ПРОЕКТ"
                        color: "#ffffff"
                        font.pointSize: 9
                        Layout.column: 0
                        font.weight: Font.Bold
                        wrapMode: Text.WordWrap
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.leftMargin: 0.005 * parent.width
                        Layout.preferredWidth: 0.25 * parent.width
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    }

                    Label{  // дата создания проекта
                        text: "СОЗДАН"
                        color: "#ffffff"
                        font.pointSize: 9
                        Layout.column: 1
                        font.weight: Font.Bold
                        wrapMode: Text.WordWrap
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.preferredWidth: 0.15 * parent.width
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    }

                    Label{  // дата изменения проекта
                        text: "ИЗМЕНЕН"
                        color: "#ffffff"
                        font.pointSize: 9
                        Layout.column: 2
                        font.weight: Font.Bold
                        wrapMode: Text.WordWrap
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.preferredWidth: 0.15 * parent.width
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    }

                    Label{  // тип входных данных
                        text: "ДАННЫЕ"
                        color: "#ffffff"
                        font.pointSize: 9
                        Layout.column: 3
                        font.weight: Font.Bold
                        wrapMode: Text.WordWrap
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.preferredWidth: 0.17 * parent.width
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    }

                    Label{  // выбранный уровень безопасности для анализа
                        text: "УРОВЕНЬ"
                        color: "#ffffff"
                        font.pointSize: 9
                        Layout.column: 4
                        font.weight: Font.Bold
                        wrapMode: Text.WordWrap
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.preferredWidth: 0.14 * parent.width
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    }

                    Label{  // выбранный уровень безопасности для анализа
                        text: "MASVS"
                        color: "#ffffff"
                        font.pointSize: 9
                        Layout.column: 5
                        font.weight: Font.Bold
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.rightMargin: 0.005 * parent.width
                        Layout.preferredWidth: 0.12 * parent.width
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    }
                }
            }

            //карточка с параметрами
            delegate: Rectangle{
                width: parent.width
                height: 60
                radius: 5
                opacity: 0.9

                gradient: Gradient {
                    GradientStop { position: 0.00; color: "#ffffff"}
                    GradientStop { position: 1.00; color: "#E6E6FA"}
                }

                GridLayout{
                    rows: 2
                    columns: 6
                    columnSpacing: 0
                    anchors.fill: parent

                    Label{  // название проекта
                        text: name
                        Layout.row: 0
                        Layout.column: 0
                        font.pointSize: 10
                        Layout.topMargin: 5
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.leftMargin: 0.005 * parent.width
                        Layout.preferredWidth: 0.25 * parent.width
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        elide: Text.ElideMiddle // если название слишком большое, то в центре будет троеточие
                    }

                    Label{  // проценты
                        text: percent
                        Layout.row: 1
                        Layout.column: 0
                        font.pointSize: 10
                        Layout.bottomMargin: 5
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.leftMargin: 0.005 * parent.width
                        Layout.preferredWidth: 0.25 * parent.width
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    }

                    Label{  // путь к исходному файлу
                        text: "Путь к APK: " + path_apk
                        Layout.row: 1
                        Layout.column: 1
                        Layout.columnSpan: 4
                        font.pointSize: 10
                        Layout.bottomMargin: 5
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        Layout.preferredWidth: 0.57 * parent.width
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        elide: Text.ElideMiddle // если название слишком большое, то в центре будет троеточие
                    }

                    Label{  // дата создания проекта
                        text: create_date
                        Layout.row: 0
                        Layout.column: 1
                        font.pointSize: 10
                        Layout.topMargin: 5
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.preferredWidth: 0.15 * parent.width
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    }

                    Label{  // дата изменения проекта
                        text: edit_date
                        Layout.row: 0
                        Layout.column: 2
                        font.pointSize: 10
                        Layout.topMargin: 5
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.preferredWidth: 0.15 * parent.width
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    }

                    // тип входных данных

                    // only Apk
                    RowLayout{
                        id: row_apk
                        spacing: 0
                        Layout.row: 0
                        Layout.column: 3
                        Layout.topMargin: 5
                        Layout.preferredWidth: 0.17 * parent.width
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        visible: {
                            if (input_data == "Только APK"){
                                row_apk.visible = true
                            }
                            else{
                                row_apk.visible = false
                            }
                        }

                        Rectangle{
                            id: apk_label
                            Layout.preferredWidth: 32
                            Layout.preferredHeight: 20
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            color: "#FFD51A"
                            radius: 3

                            Label{
                                text: "APK"
                                font.pointSize: 8
                                anchors.fill: parent
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                    }

                    // Apk and Code
                    RowLayout{
                        id: row_apk_code
                        spacing: 3
                        Layout.row: 0
                        Layout.column: 3
                        Layout.topMargin: 5
                        Layout.preferredWidth: 0.17 * parent.width
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        visible: {
                            if (input_data != "Только APK"){
                                row_apk_code.visible = true
                            }
                            else{
                                row_apk_code.visible = false
                            }
                        }

                        Rectangle{
                            Layout.preferredWidth: 32
                            Layout.preferredHeight: 20
                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                            color: "#FFD51A"
                            radius: 3

                            Label{
                                text: "APK"
                                font.pointSize: 8
                                anchors.fill: parent
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }

                        Rectangle{
                            id: code_label
                            Layout.preferredWidth: 32
                            Layout.preferredHeight: 20
                            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                            color: "#64FCAA"
                            radius: 3

                            Label{
                                text: "CODE"
                                font.pointSize: 8
                                anchors.fill: parent
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                    }

                    // выбранный уровень безопасности для анализа
                    RowLayout{
                        spacing: 3
                        Layout.row: 0
                        Layout.column: 4
                        Layout.topMargin: 5
                        Layout.preferredWidth: 0.14 * parent.width
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        Rectangle{
                            id: level_label
                            Layout.preferredWidth: 44
                            Layout.preferredHeight: 20
                            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                            color: "#99E1FF"
                            radius: 3

                            Label{
                                text: level
                                font.pointSize: 8
                                anchors.fill: parent
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                    }

                    Button{
                        id: button
                        text: "ОТЧЁТ"
                        Layout.row: 0
                        Layout.column: 5
                        Layout.rowSpan: 2
                        font.pointSize: 9
                        Layout.rightMargin: 0.005 * parent.width
                        Layout.preferredWidth: 0.12 * parent.width
                        Material.foreground: "#ffffff"  // цвет текста
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        background: Rectangle {
                            Gradient {
                                id: normalGradient
                                GradientStop { position: 0.0; color: "#3B3B3B" }
                                GradientStop { position: 1.0; color: "#1C1C1C" }
                            }
                            Gradient {
                                id: hoveredGradient
                                GradientStop { position: 0.0; color: "#5C5C5C" }
                                GradientStop { position: 1.0; color: "#3B3B3B" }
                            }
                            implicitHeight: 40
                            gradient: button.hovered ? hoveredGradient :
                                      normalGradient
                            radius: 5
                        }


                        onClicked: {
                            pushanimation.start()
                            showReport(name);
                        }

                        ScaleAnimator{
                            id: pushanimation
                            target: button
                            from: 0.9
                            to: 1.0
                        }
                    }
                }
            }
        }
    }
}
