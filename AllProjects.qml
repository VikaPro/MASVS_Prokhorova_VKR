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

    // делаем отдельную шапку, т.к. модель с проектами необходимо очищать
    header:Rectangle{
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
                allProjects.visible = false
                selectProject.visible = true
                _projects.clearR();            // очищаем модель с проектами воизбежание дублирования
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
            text: "СПИСОК СУЩЕСТВУЮЩИХ ПРОЕКТОВ"
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
                allProjects.visible = false
                selectProject.visible = true
                _projects.clearR();            // очищаем модель с проектами воизбежание дублирования
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


    ColumnLayout{
        anchors.fill: parent
        spacing: 10

        // общий заголовок для всех карточек с проектами
        Rectangle{
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredHeight: 50
            Layout.preferredWidth: 0.9 * parent.width
            Layout.topMargin: 10
            radius: 5
            gradient: Gradient {
                GradientStop {
                    color: "#000000"
                    position: 0.00;
                }
                GradientStop {
                    position: 1.00;
                    color: "#80CBC4"
                }
            }

            GridLayout{
                anchors.fill: parent
                columns: 4
                rows: 1

                Label{  // название проекта
                    text: "ПРОЕКТ"
                    Layout.column: 0
                    wrapMode: Text.WordWrap
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.preferredWidth: 0.3 * parent.width
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                }

                Label{  // дата создания проекта
                    text: "СОЗДАН"
                    Layout.column: 1
                    wrapMode: Text.WordWrap
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.preferredWidth: 0.15 * parent.width
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                }

                Label{  // дата изменения проекта
                    text: "ИЗМЕНЕН"
                    Layout.column: 2
                    wrapMode: Text.WordWrap
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.preferredWidth: 0.15 * parent.width
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                }

                Label{
                    text: "MASVS"
                    Layout.column: 3
                    wrapMode: Text.WordWrap
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.preferredWidth: 0.15 * parent.width
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                }

            }
        }

        ListView{
            id: listView
            Layout.alignment: Qt.AlignHCenter
            Layout.fillHeight: true
            Layout.preferredWidth: 0.9 * parent.width
            Layout.bottomMargin: 10
            Layout.topMargin: 10
            spacing: 20
            model: _projects //модель со всеми существующими проектами

            //карточка с параметрами
            delegate: Rectangle{
                width: parent.width
                height: 50
                radius: 5
                gradient: Gradient {
                    GradientStop {
                        color: "#80CBC4"
                        position: 0.00;
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

                    Label{  // название проекта
                        text: name
                        Layout.column: 0
                        wrapMode: Text.WordWrap
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.preferredWidth: 0.3 * parent.width
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    }

                    Label{  // дата создания проекта
                        text: create_date
                        Layout.column: 1
                        wrapMode: Text.WordWrap
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.preferredWidth: 0.15 * parent.width
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    }

                    Label{  // дата изменения проекта
                        text: edit_date
                        Layout.column: 2
                        wrapMode: Text.WordWrap
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.preferredWidth: 0.15 * parent.width
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    }

                    Button{
                        text: "Отчёт"
                        Layout.column: 3
                        Layout.alignment: Qt.AlignHCenter
                        Layout.preferredWidth: 0.15 * parent.width
                        onClicked: {
                            showReport(name);
                        }
                    }
                }
            }
        }
    }
}
