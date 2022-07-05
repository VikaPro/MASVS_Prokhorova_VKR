import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3
import QtGraphicalEffects 1.12

Page {

    Item {
        id: varItem
        property string aNumber: ""
        property string aProject: ""
        property string aResult: ""
    }


    Connections {
        target: _select;  // первые два сигнала находятся в usertesting

        onShowOneTest:{
            varItem.aProject = nameProd
            varItem.aNumber = numberReq
            varItem.aResult = resultReq
            readReport.visible = false
            oneUserTest.visible = true
            number_label.text = "Требование MASVS № " + numberReq;
            description_label.text = nameReq;
            if (resultReq == "ВЫПОЛНЕНО"){
                result_label.text = "ВЫПОЛНЕНО"
                result_label.color = "#02BB3D";

            }
            else if (resultReq == "НЕИЗВЕСТНО"){
                result_label.text = "НЕИЗВЕСТНО"
                result_label.color = "#ED9702";

            }
            else{
                result_label.text = "НЕ ВЫПОЛНЕНО"
                result_label.color = "#BB0233";
            }
            if (numberReq == "1.1"){
                note_label.text = req_1_1.text
            }
            else if (numberReq == "1.2"){
                note_label.text = req_1_2.text
            }
            else if (numberReq == "1.3"){
                note_label.text = req_1_3.text
            }
            else if (numberReq == "1.4"){
                note_label.text = req_1_4.text
            }
            else{
                note_label.text = req_1_6.text
            }

        }

        onReadReport:{     // после нажатия на кнопку "отчёт" отобразится страница с конкретным отчётом
            oneUserTest.visible = false
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

    header: TopEasy{
        Item {
            id: varItemEasy
            property string aTextEasy: "ИЗМЕНИТЬ РЕЗУЛЬТАТ ПРОВЕРКИ"
        }
    }

    ColumnLayout{
        width: 0.8 * parent.width
        height: parent.height
        anchors.centerIn: parent
        spacing: 0

        Rectangle{
            color: "#ffffff"
            opacity: 0.9
            radius: 5
            Layout.topMargin: 20
            Layout.bottomMargin: 20
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            ColumnLayout{
                width: 0.95 * parent.width
                height: 0.95 * parent.height
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
                    Layout.preferredHeight: 0.1 * parent.height
                }

                Label {
                    id: result_label
                    lineHeight: 1.1
                    font.pointSize: 12
                    font.bold: true
                    color: "#02BB3D"   // по умолчанию поставим зелёный цвет - выполнено
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 0.1 * parent.height
                }

                Label {
                    lineHeight: 1.1
                    font.pointSize: 10
                    text: "Измените своё решения, нажав на нужную кнопку"
                    wrapMode: Text.WordWrap
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 0.1 * parent.height
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
                            changeRes(varItem.aProject, varItem.aNumber, description_label.text, "ВЫПОЛНЕНО")
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
                            changeRes(varItem.aProject, varItem.aNumber, description_label.text, "НЕ_ВЫПОЛНЕНО")
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
                            changeRes(varItem.aProject, varItem.aNumber, description_label.text, varItem.aResult)
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
                    textFormat: Text.RichText
                    //TextBrowserInteraction
                    //textInteraction
                    wrapMode: Text.WordWrap
                    Layout.alignment: Qt.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 0.45 * parent.height
                    // Не работает почему-то именно здесь, мб из-за переноса строк
                    //elide: Text.ElideMiddle // если описание слишком длинное, то в центре будет троеточие, нужно расширить окно
                }
            }
        }
    }
    Text {
        id: req_1_1
        text: "Каждый компонент приложения имеет свой уникальный ID, который позволяет идентифицировать его среди других различных компонентов в одном и том же приложении.
Компонент приложения будет создан при первом обращении к нему. Любые дальнейшие обращения будут возвращать тот же экземпляр компонента.
<br>Подробности см. здесь: <a href=\"https://owasp.org/www-community/Application_Threat_Modeling\">Тестирование мобильных приложений"
        visible: false
    }

    Text {
        id: req_1_2
        visible: false
        text: "Данная проверка выполняется в нескольких плоскостях. Например, при тестировании аутентификации и авторизации следует выполнить следующие шаги:<br>
- Определить дополнительные факторы аутентификации, которые использует приложение.<br>
- Найти все конечные точки, обеспечивающие важные функции.<br>
- Убедиться, что дополнительные факторы строго соблюдаются на всех конечных точках на стороне сервера.<br>
Подробности можно узнать в следующих разделах MSTG:<br>
<a href=\"https://owasp.org/www-community/Application_Threat_Modeling\">Архитектура аутентификации мобильных приложений (MSTG-ARCH-2 и MSTG)</a><br>
<a href=\"https://owasp.org/www-community/Application_Threat_Modeling\">Угроза инъекции (MSTG-ARCH-2 и MSTG-PLATFORM-2)</a>"
    }

    Text {
        id: req_1_3
        visible: false
        text: "Данное требование частично связано с Требованием 1.2.
Наиважнейшим условием построение стрессоустойчивой архитектуры является отделение ядра системы от GUI, настолько, что б одно, могло успешно функционировать без другого.
Все возможные инструменты и методы безопасности должны быть заложены ещё на этапе проектирования мобильного приложения."
    }

    Text {
        id: req_1_4
        visible: false
        text: "Поиск различной чувствительной информации необходимо вести в достаточно большом количестве источников и форматов. Но основной интерес представляет собой не сам первоначальный поиск данных, который вполне понятен и очевиден, а валидация того, что они больше нигде не хранятся.
<br>Подробнее см. здесь:
<a href=\"https://owasp.org/www-community/Application_Threat_Modeling\">Поиск чувствительной информации в мобильных приложениях</a>"
    }

    Text {
        id: req_1_6
        visible: false
        text: "Стандарт MASVS предлагает свой подход к моделированию угроз, описанный в документе <a href=\"https://owasp.org/www-community/Application_Threat_Modeling\">OWASP Threat modelling</a> -
Для соответствия данному требованию Вы можете воспользоваться отечественным аналогом - проектом методического документа ФСТЭК «Методика моделирования угроз безопасности информации» от 2020г."
    }
}
