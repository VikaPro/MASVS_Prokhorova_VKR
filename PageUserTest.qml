import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3
import QtGraphicalEffects 1.12

Page {

    Connections {
        target: _user;  // первые два сигнала находятся в usertesting

        onColUserTest:{
            prog_bar.to = col;
        }
        onShowUserCard:{
            prog_bar.value = index;
            number_label.text = "Требование MASVS № " + number;
            description_label.text = description;
        }
        onAllTestEnd:{     // когда сформируется отчёт, то отобразится страница с ним
            pageUserTest.visible = false
            readReport.visible = true
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


    // Жёлтый цвет для результата НЕИЗВЕСТНО
    // тёмный жёлтый цвет
    Gradient {
        id: yellow_normal_Gradient
        GradientStop { position: 0.0; color: "#FFDB4D" }
        GradientStop { position: 1.0; color: "#DAA520" }
    }
    // светлый жёлтый цвет
    Gradient {
        id: yellow_hovered_Gradient
        GradientStop { position: 0.0; color: "#FFF6B8" }
        GradientStop { position: 1.0; color: "#EED468" }
    }


    visible: false
    anchors.fill: parent

    // заголовок с кнопкой "пропустить все"
    header: TopUser{
    }

    ColumnLayout{
        width: 0.8 * parent.width
        height: parent.height
        anchors.centerIn: parent

        Rectangle{
            color: "#ffffff"
            opacity: 0.9
            radius: 5
            Layout.topMargin: 20
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            ColumnLayout{
                width: 0.9 * parent.width
                height: 0.9 * parent.height
                anchors.centerIn: parent
                spacing: 0

                Label {
                    id: number_label
                    font.bold: true
                    lineHeight: 1.1
                    font.pointSize: 12
                    wrapMode: Text.WordWrap
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 0.1 * parent.height
                }

                Label {
                    id: description_label
                    lineHeight: 1.1
                    font.pointSize: 10
                    text: "Информация о статусе тестирования будет отображаться здесь"
                    wrapMode: Text.WordWrap
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 0.2 * parent.height
                }

                // сюда три кнопки
                RowLayout{
                    Layout.fillHeight: true
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 0.15 * parent.height
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    spacing: 10

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
                            resultUser(number_label.text, description_label.text, "ВЫПОЛНЕНО", prog_bar.value)
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
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        background: Rectangle {
                            radius: 5
                            implicitHeight: 40
                            gradient: but_not.hovered ? red_hovered_Gradient :
                                                        red_normal_Gradient
                        }

                        // результат можно менять только у пользовательских проверок
                        onClicked: {
                            pushanimation2.start()
                            resultUser(number_label.text, description_label.text, "НЕ_ВЫПОЛНЕНО", prog_bar.value)
                        }

                        ScaleAnimator{
                            id: pushanimation2
                            target: but_not
                            from: 0.9
                            to: 1.0
                        }
                    }

                    // Кнопка с присвоением требованию значения НЕИЗВЕСТНО, т.к. пропускаем выбор
                    Button{
                        id: but_next
                        text: "ПРОПУСТИТЬ"
                        Layout.preferredWidth: 110
                        Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter

                        background: Rectangle {
                            radius: 5
                            implicitHeight: 40
                            gradient: but_next.hovered ? yellow_hovered_Gradient :
                                                           yellow_normal_Gradient
                        }

                        // результат можно менять только у пользовательских проверок
                        onClicked: {
                            pushanimation3.start()
                            resultUser(number_label.text, description_label.text, "НЕИЗВЕСТНО", prog_bar.value)
                        }

                        ScaleAnimator{
                            id: pushanimation3
                            target: but_next
                            from: 0.9
                            to: 1.0
                        }
                    }
                }

                //сюда описание
                Label {
                    id: note_label
                    lineHeight: 1.1
                    font.pointSize: 10
                    text: "Стандарт MASVS предлагает свой подход к моделированию угроз, описанный в документе <a href=\"https://owasp.org/www-community/Application_Threat_Modeling\">OWASP Threat modelling</a> -
Для соответствия данному требованию Вы можете воспользоваться отечественным аналогом - проектом методического документа ФСТЭК «Методика моделирования угроз безопасности информации» от 2020г."
                    textFormat: Text.RichText
                    //TextBrowserInteraction
                    //textInteraction
                    wrapMode: Text.WordWrap
                    Layout.alignment: Qt.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 0.5 * parent.height
                    // Не работает почему-то именно здесь, мб из-за переноса строк
                    //elide: Text.ElideMiddle // если описание слишком длинное, то в центре будет троеточие, нужно расширить окно
                }
            }
        }

        RowLayout{
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 0.1 * parent.height
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.bottomMargin: 20

            ProgressBar{
                id: prog_bar
                value: 0
                from: 0
                to: 24

                Layout.alignment: Qt.AlignHCenter| Qt.AlignVCenter
                Layout.fillWidth: true
                Layout.preferredHeight: 15

                background: Rectangle {           //это фоновая строка до первого теста
                    color: "#ffffff"
                    opacity: 0.6
                    radius: 5
                }

                Rectangle {     //показывает, сколько требований уже прошло
                    width: prog_bar.visualPosition * parent.width
                    height: 15
                    color: "#53BDE9"
                    radius: 5
                }
            }

            Label {
                text: prog_bar.value + "/" + prog_bar.to
                font.pointSize: 10
                color: "#ffffff"
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.preferredHeight: 15
            }
        }
    }
}
