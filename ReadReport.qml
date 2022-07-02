import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.3
import QtGraphicalEffects 1.12
import QtQuick.Controls.Material 2.3

Page {
    Item {
        id: varName
        property string aName: ""
    }

    Connections {
        target: _select     // все эти сигналы находятся в selectproject

        onSendName:{
            label_header.text = "ОТЧЁТ ПО ПРОЕКТУ: " + name
            varName.aName = name
        }

        /*onEndExportCSV:{
            messageDialog.visible = true
            messageDialog.text = "Отчёт успешно экспортирован в: " + dialog_csv.fileUrl
        }

        onEndExportPDF:{
            messageDialog.visible = true
            messageDialog.text = "Отчёт успешно экспортирован в: " + dialog_pdf.fileUrl
        }*/
    }

    FileDialog {                                    // Диалоговое окно для выбора шифруемого файла
        id: dialog_csv
        title: "Создайте файл *.csv для экспорта отчёта"
        folder: shortcuts.documents                 // стартово открывает каталог "Документы"
        nameFilters: [ "CSV Files(*.csv)" ]         // видим только csv файлы
        selectExisting: false                       // создаем именно новые файлы
        onAccepted: {
            // при нажатии "открыть" получаем url файла типа "file:///путь/имя"
            if (dialog_csv.fileUrl != ""){
                _report.exportCSV(dialog_csv.fileUrl);            // экспортируем
            }
        }
    }

    FileDialog {                                    // Диалоговое окно для выбора шифруемого файла
        id: dialog_pdf
        title: "Создайте файл *.pdf для экспорта отчёта"
        folder: shortcuts.documents                     // стартово открывает каталог "Документы"
        nameFilters: [ "Pdf File(*.pdf)"]               // видим только pdf файлы
        selectExisting: false                           // создаем именно новые файлы
        onAccepted: {
            // при нажатии "открыть" получаем url файла типа "file:///путь/имя"
            if (dialog_pdf.fileUrl != ""){
                _report.exportPDF(dialog_pdf.fileUrl);            // экспортируем
            }
        }
    }


    /***Цвета для всевозможных кнопок***/

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

    // Голубой цвет для нижних кнопок с функциями экспорта и статистикой
    // тёмный голубой цвет
    Gradient {
        id: blue_normal_Gradient
        GradientStop { position: 0.0; color: "#57CDFF" }
        GradientStop { position: 1.0; color: "#1D84AF" }
    }
    // светлый голубой цвет
    Gradient {
        id: blue_hovered_Gradient
        GradientStop { position: 0.0; color: "#B8EAFF" }
        GradientStop { position: 1.0; color: "#57ADD1" }
    }


    visible: false
    anchors.fill: parent

    header: Rectangle{
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

        // кнопка "Назад"
        MouseArea{
            id:undo_tab
            width: 40
            height: 40
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 20

            // изменение цвета иконки при наведении
            hoverEnabled: true
            onEntered: {
                image_undo.source = "qrc:/image/image/undo_light.png"
            }
            onExited: {
                image_undo.source = "qrc:/image/image/undo.png"
            }

            // вдавливание кнопки не делаем, т.к. не успевает отобразиться
            onClicked: {
                readReport.visible = false
                allProjects.visible = true
            }

            Image {
                id: image_undo
                anchors.fill: parent
                source: "qrc:/image/image/undo.png"
            }

            DropShadow {
                anchors.fill: image_undo
                horizontalOffset: 3
                verticalOffset: 3
                radius: 8.0
                samples: 17
                color: "#80000000"  // чёрный прозрачный
                source: image_undo
            }
        }


        Label {
            id: label_header
            font.pointSize: 12
            wrapMode: Text.WordWrap
            anchors.fill: parent
            font.weight: Font.DemiBold
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.capitalization: Font.AllUppercase
        }

        // кнопка "Домой"
        MouseArea{
            id: home_tab
            width: 40
            height: 40
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins: 20

            // изменение цвета иконки при наведении
            hoverEnabled: true
            onEntered: {
                image_home.source = "qrc:/image/image/home_light.png"
            }
            onExited: {
                image_home.source = "qrc:/image/image/home.png"
            }

            // вдавливание кнопки не делаем, т.к. не успевает отобразиться
            onClicked: {
                readReport.visible = false
                selectProject.visible = true
            }

            Image {
                id: image_home
                anchors.fill: parent
                source: "qrc:/image/image/home.png"
            }

            DropShadow {
                anchors.fill: image_home
                horizontalOffset: 3
                verticalOffset: 3
                radius: 8.0
                samples: 17
                color: "#80000000"  // чёрный прозрачный
                source: image_home
            }
        }
    }



    ColumnLayout{
        anchors.fill: parent

        // список с карточками всех требований
        ListView{
            id: listView
            Layout.alignment: Qt.AlignHCenter
            Layout.fillHeight: true
            Layout.preferredWidth: 0.95 * parent.width
            Layout.topMargin: 10
            spacing: 4
            clip: true
            model: _report // модель отчёта со всеми требованиями

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
                    rows: 1
                    columns: 4
                    columnSpacing: 0.005 * parent.width
                    anchors.fill: parent

                    Label{          // номер требования
                        id: label_number
                        text: number
                        font.bold: true
                        Layout.column: 0
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.leftMargin: 0.005 * parent.width
                        Layout.preferredWidth: 0.07 * parent.width
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    }

                    Label{          // описание или название требования
                        id: label_desc
                        text: description
                        Layout.column: 1
                        font.pointSize: 9
                        wrapMode: Text.WordWrap
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        Layout.fillWidth: true
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    }

                    // необходима для определения ручной или автоматизированной проверки
                    Label{
                        id: label_text
                        text: func
                        visible: false
                    }

                    Button{ // кнопка с результатом проверки
                        id: but_result
                        text: {
                            if (result == "НЕ_ВЫПОЛНЕНО"){
                                but_result.text = "НЕ ВЫПОЛНЕНО"
                            }
                            else{
                                but_result.text = result
                            }
                        }
                        Layout.column: 3
                        font.pointSize: 8
                        Layout.rightMargin: 0.005 * parent.width
                        Layout.preferredWidth: 0.2 * parent.width
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                        // при наведении на кнопку с автоматизированной проверкой - она не светится
                        background: Rectangle {
                            radius: 5
                            implicitHeight: 40
                            gradient: {
                                if (result == "ВЫПОЛНЕНО"){
                                    if (label_text.text == "Пользователь"){
                                        but_result.hovered ? green_hovered_Gradient :
                                        green_normal_Gradient
                                    }
                                    else{
                                        green_normal_Gradient
                                    }
                                }
                                else if (result == "НЕ_ВЫПОЛНЕНО"){
                                    if (label_text.text == "Пользователь"){
                                        but_result.hovered ? red_hovered_Gradient :
                                        red_normal_Gradient
                                    }
                                    else{
                                        red_normal_Gradient
                                    }
                                }
                                else if (result == "НЕИЗВЕСТНО"){
                                    if (label_text.text == "Пользователь"){
                                        but_result.hovered ? yellow_hovered_Gradient :
                                        yellow_normal_Gradient
                                    }
                                    else{
                                        yellow_normal_Gradient
                                    }
                                }
                            }
                        }

                        // результат можно менять только у пользовательских проверок
                        onClicked: {
                            if (label_text.text == "Пользователь"){
                                pushanimation2.start()
                                // здесь будет передача текста в функцию и получения странички с кодом (или popup с крестиком)
                            }
                        }

                        ScaleAnimator{
                            id: pushanimation2
                            target: but_result
                            from: 0.9
                            to: 1.0
                        }
                    }
                }
            }
        }

        RowLayout{
            Layout.fillWidth: true
            Layout.preferredHeight: 45
            Layout.alignment: Qt.AlignHCenter

            Button{
                id: button_1
                text: "Экспорт CSV"
                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                background: Rectangle {
                    implicitHeight: 40
                    gradient: button_1.hovered ? blue_hovered_Gradient :
                              blue_normal_Gradient
                    radius: 5
                }

                onClicked: {
                    pushanimation_1.start()
                    dialog_csv.open()       // открываем проводник
                }

                ScaleAnimator{
                    id: pushanimation_1
                    target: button_1
                    from: 0.9
                    to: 1.0
                }
            }
            Button{
                id: button_2
                text: "Экспорт PDF"
                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                background: Rectangle {
                    implicitHeight: 40
                    gradient: button_2.hovered ? blue_hovered_Gradient :
                              blue_normal_Gradient
                    radius: 5
                }

                onClicked: {
                    pushanimation_2.start()
                    dialog_pdf.open()       // открываем проводник
                }

                ScaleAnimator{
                    id: pushanimation_2
                    target: button_2
                    from: 0.9
                    to: 1.0
                }
            }
        }

        RowLayout{
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            Layout.bottomMargin: 10
            Layout.preferredHeight: 45

            Button{
                id: button_3
                text: "Сводная статистика"
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                background: Rectangle {
                    implicitHeight: 40
                    implicitWidth: button_4.width
                    gradient: button_3.hovered ? blue_hovered_Gradient :
                              blue_normal_Gradient
                    radius: 5
                }

                onClicked: {
                    pushanimation_3.start()
                    checkPercent(varName.aName)
                    readReport.visible = false
                    percentPage.visible = true
                }

                ScaleAnimator{
                    id: pushanimation_3
                    target: button_3
                    from: 0.9
                    to: 1.0
                }
            }
            Button{
                id: button_4
                text: "Продолжить тестирование"
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                background: Rectangle {
                    implicitHeight: 40
                    gradient: button_4.hovered ? blue_hovered_Gradient :
                              blue_normal_Gradient
                    radius: 5
                }

                onClicked: {
                    pushanimation_4.start()
                }

                ScaleAnimator{
                    id: pushanimation_4
                    target: button_4
                    from: 0.9
                    to: 1.0
                }
            }
        }
    }
}
