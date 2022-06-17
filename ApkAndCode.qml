import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.3
import QtQuick.Controls.Material 2.3

Page {

    Connections {
        target: _select     // все эти сигналы находятся в selectproject

        onDownloadedSource:{     // после загрузки файлов переходим к выбору уровня безопасности
            apkAndCode.visible = false
            levelSec.visible = true
        }

        onErrorSource:{    // в случае, если пользователь загрузил что-то не то
            top_label.text = error
            but_confirm.enabled = false  // дезактивируем кнопку для перехода к следующей странице
        }
    }

    // Выбор файла APK
    FileDialog {                                    // Диалоговое окно для выбора шифруемого файла
        id: dialog_apk
        title: "Выберите файл APK для анализа"
        folder: shortcuts.documents                 // стартово открывает каталог "Документы"
        //nameFilters: [ "Text files (*.apk)"]        // видим только apk файлы
        // возможно придётся убрать, смотря как хорошо будет декомпилироваться xapk
        nameFilters: [ "Text files (*.apk *.xapk)"]        // видим только apk файлы и xapk файлы
        onAccepted: {
            // при нажатии "открыть" получаем url файла типа "file:///путь/имя"
            if (dialog_apk.fileUrl != ""){
                apk_area.text = "Выбранный файл APK: " + dialog_apk.fileUrl
                // меняем цвет кнопки на зелёный
                grad1_apk.color = "#99FFBE"
                grad2_apk.color = "#57D181"

                // проверяем, может это был последний файл для выбора
                // если да, то активиирум кнопку для перехода на след. страницу
                if ((apk_area.text != "") && (android_area.text != "") && (src_area.text != "")){
                    but_confirm.enabled = true  // активируем кнопку для перехода к следующей странице
                }
            }
        }
    }

    // Выбор директории со всеми файлами до компиляции APK
    FileDialog {                                    // Диалоговое окно для выбора шифруемого файла
        id: dialog_android
        title: "Выберите каталог со всеми файлами до компиляции APK"
        selectFolder: true
        folder: shortcuts.documents                 // стартово открывает каталог "Документы"
        onAccepted: {
            // при нажатии "открыть" получаем url файла типа "file:///путь/имя"
            if (dialog_android.fileUrl != ""){
                android_area.text = "Выбранный каталог Android проекта: " + dialog_android.fileUrl
                // меняем цвет кнопки на зелёный
                grad1_android.color = "#99FFBE"
                grad2_android.color = "#57D181"

                // проверяем, может это был последний файл для выбора
                // если да, то активиирум кнопку для перехода на след. страницу
                if ((apk_area.text != "") && (android_area.text != "") && (src_area.text != "")){
                    but_confirm.enabled = true  // активируем кнопку для перехода к следующей странице
                }
            }
        }
    }

    // Выбор директории со всеми файлами исходного кода
    FileDialog {                                    // Диалоговое окно для выбора шифруемого файла
        id: dialog_src
        title: "Выберите каталог со всеми файлами исходного кода"
        selectFolder: true
        folder: shortcuts.documents                 // стартово открывает каталог "Документы"
        onAccepted: {
            // при нажатии "открыть" получаем url файла типа "file:///путь/имя"
            if (dialog_src.fileUrl != ""){
                src_area.text = "Выбранный каталог с исходным кодом: " + dialog_src.fileUrl
                // меняем цвет кнопки на зелёный
                grad1_src.color = "#99FFBE"
                grad2_src.color = "#57D181"

                // проверяем, может это был последний файл для выбора
                // если да, то активиирум кнопку для перехода на след. страницу
                if ((apk_area.text != "") && (android_area.text != "") && (src_area.text != "")){
                    but_confirm.enabled = true  // активируем кнопку для перехода к следующей странице
                }
            }
        }
    }


    visible: false
    anchors.fill: parent

    header: Top{
        Item {
            id: varItem
            property string aText: "ЗАГРУЗКА APK ФАЙЛА И ИСХОДНОГО КОДА"
            property var aPageFalse: apkAndCode
            property var aPageTrue: downloadWindow
        }
    }

    ColumnLayout{
        height: parent.height
        width: 0.9 * parent.width
        anchors.centerIn: parent

        Label {
            id: top_label
            color: "#ffffff"
            font.pointSize: 12
            text: "Загрузите все необходимые файлы или выберите другой тип загрузки на предыдущем шаге"
            lineHeight: 1.1
            wrapMode: Text.WordWrap
            Layout.topMargin: 10
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.preferredWidth: parent.width
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        // Для загрузки APK
        RowLayout{
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 60
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            spacing: 10

            ScrollView {
                focusPolicy: Qt.WheelFocus
                Layout.preferredHeight: parent.height
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter

                TextArea{
                    id:  apk_area
                    enabled: false // отключаем возможность ввода с клавиатуры
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.preferredHeight: parent.height
                    Layout.preferredWidth: parent.width
                    font.pointSize: 10
                    wrapMode: Text.WordWrap
                    textFormat: Text.AutoText
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    placeholderText: qsTr("Выбрать APK-файл")
                    background: Rectangle{
                        anchors.fill: parent
                        radius: 5
                        opacity: 0.95
                        gradient: Gradient {
                            GradientStop { position: 0.00; color: "#ffffff"}
                            GradientStop { position: 1.00; color: "#E6E6FA"}
                        }
                    }
                }
            }

            // Кастомная кнопка для выбора файла APK из проводника
            MouseArea{
                id: but_apk
                Layout.preferredWidth: 60
                Layout.preferredHeight: 60
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter

                // фон для кнопки
                Rectangle{
                    anchors.fill: parent
                    radius: 5
                    gradient: Gradient {
                        GradientStop {
                            id: grad1_apk
                            position: 0.00;
                            color: "#99E1FF"
                        }
                        GradientStop {
                            id: grad2_apk
                            position: 1.00;
                            color: "#57ADD1"
                        }
                    }
                }

                // Картинка файла apk
                Image {
                    width: 50
                    height:  50
                    anchors.centerIn: parent
                    source: "qrc:/image/image/file_apk.png"
                }

                // изменение цвета карточки при наведении
                // если файлы не выбраны, то цвет голубой, иначе зелёный
                hoverEnabled: true
                onEntered: {
                    //голубой цвет
                    if (apk_area.text == ""){
                        grad1_apk.color = "#D7F3FE"
                        grad2_apk.color = "#99E1FF"
                    }
                    //зелёный цвет
                    else{
                        grad1_apk.color = "#D7FEE5"
                        grad2_apk.color = "#99FFBE"
                    }

                }
                onExited: {
                    //голубой цвет
                    if (apk_area.text == ""){
                        grad1_apk.color = "#99E1FF"
                        grad2_apk.color = "#57ADD1"
                    }
                    //зелёный цвет
                    else{
                        grad1_apk.color = "#99FFBE"
                        grad2_apk.color = "#57D181"
                    }
                }
                onClicked: {
                    dialog_apk.open()       // открываем проводник
                }
            }
        }

        // Для загрузки каталога Android проекта
        RowLayout{
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 60
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            spacing: 10

            ScrollView {
                focusPolicy: Qt.WheelFocus
                Layout.preferredHeight: parent.height
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter

                TextArea{
                    id:  android_area
                    enabled: false // отключаем возможность ввода с клавиатуры
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.preferredHeight: parent.height
                    Layout.preferredWidth: parent.width
                    font.pointSize: 10
                    wrapMode: Text.WordWrap
                    textFormat: Text.AutoText
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    placeholderText: qsTr("Выбрать каталог Android проекта")
                    background: Rectangle{
                        anchors.fill: parent
                        radius: 5
                        opacity: 0.95
                        gradient: Gradient {
                            GradientStop { position: 0.00; color: "#ffffff"}
                            GradientStop { position: 1.00; color: "#E6E6FA"}
                        }
                    }
                }
            }

            // Кастомная кнопка для выбора каталога Android проекта
            MouseArea{
                id: but_android
                Layout.preferredWidth: 60
                Layout.preferredHeight: 60
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter

                // фон для кнопки
                Rectangle{
                    anchors.fill: parent
                    radius: 5
                    gradient: Gradient {
                        GradientStop {
                            id: grad1_android
                            position: 0.00;
                            color: "#99E1FF"
                        }
                        GradientStop {
                            id: grad2_android
                            position: 1.00;
                            color: "#57ADD1"
                        }
                    }
                }

                // Картинка каталога Android
                Image {
                    width: 50
                    height:  50
                    anchors.centerIn: parent
                    source: "qrc:/image/image/dir_project.png"
                }

                // изменение цвета карточки при наведении
                // если файлы не выбраны, то цвет голубой, иначе зелёный
                hoverEnabled: true
                onEntered: {
                    //голубой цвет
                    if (android_area.text == ""){
                        grad1_android.color = "#D7F3FE"
                        grad2_android.color = "#99E1FF"
                    }
                    //зелёный цвет
                    else{
                        grad1_android.color = "#D7FEE5"
                        grad2_android.color = "#99FFBE"
                    }

                }
                onExited: {
                    //голубой цвет
                    if (android_area.text == ""){
                        grad1_android.color = "#99E1FF"
                        grad2_android.color = "#57ADD1"
                    }
                    //зелёный цвет
                    else{
                        grad1_android.color = "#99FFBE"
                        grad2_android.color = "#57D181"
                    }
                }
                onClicked: {
                    dialog_android.open()       // открываем проводник
                }
            }
        }

        // Для загрузки исходного кода приложения
        RowLayout{
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 60
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            spacing: 10

            ScrollView {
                focusPolicy: Qt.WheelFocus
                Layout.preferredHeight: parent.height
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter

                TextArea{
                    id:  src_area
                    enabled: false // отключаем возможность ввода с клавиатуры
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.preferredHeight: parent.height
                    Layout.preferredWidth: parent.width
                    font.pointSize: 10
                    wrapMode: Text.WordWrap
                    textFormat: Text.AutoText
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    placeholderText: qsTr("Выбрать каталог с исходным кодом")
                    background: Rectangle{
                        anchors.fill: parent
                        radius: 5
                        opacity: 0.95
                        gradient: Gradient {
                            GradientStop { position: 0.00; color: "#ffffff"}
                            GradientStop { position: 1.00; color: "#E6E6FA"}
                        }
                    }
                }
            }

            // Кастомная кнопка для выбора каталога с исходным кодом приложения
            MouseArea{
                id: but_src
                Layout.preferredWidth: 60
                Layout.preferredHeight: 60
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter

                // фон для кнопки
                Rectangle{
                    anchors.fill: parent
                    radius: 5
                    gradient: Gradient {
                        GradientStop {
                            id: grad1_src
                            position: 0.00;
                            color: "#99E1FF"
                        }
                        GradientStop {
                            id: grad2_src
                            position: 1.00;
                            color: "#57ADD1"
                        }
                    }
                }

                // Картинка каталога с исходным кодом
                Image {
                    width: 50
                    height:  50
                    anchors.centerIn: parent
                    source: "qrc:/image/image/dir_code.png"
                }

                // изменение цвета карточки при наведении
                // если файлы не выбраны, то цвет голубой, иначе зелёный
                hoverEnabled: true
                onEntered: {
                    //голубой цвет
                    if (src_area.text == ""){
                        grad1_src.color = "#D7F3FE"
                        grad2_src.color = "#99E1FF"
                    }
                    //зелёный цвет
                    else{
                        grad1_src.color = "#D7FEE5"
                        grad2_src.color = "#99FFBE"
                    }

                }
                onExited: {
                    //голубой цвет
                    if (src_area.text == ""){
                        grad1_src.color = "#99E1FF"
                        grad2_src.color = "#57ADD1"
                    }
                    //зелёный цвет
                    else{
                        grad1_src.color = "#99FFBE"
                        grad2_src.color = "#57D181"
                    }
                }
                onClicked: {
                    dialog_src.open()       // открываем проводник
                }
            }
        }

        //Кнопка для подтверждения выбранных файлов, которая активируется, только если пользователь выбрал все три файла/каталога
        Button{
            id: but_confirm
            enabled: false
            text: "ПОДТВЕРДИТЬ"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            background: Rectangle {
                Gradient {
                    id: normalGradient
                    GradientStop { position: 0.0; color: "#57CDFF" }
                    GradientStop { position: 1.0; color: "#1D84AF" }
                }
                Gradient {
                    id: hoveredGradient
                    GradientStop { position: 0.0; color: "#B8EAFF" }
                    GradientStop { position: 1.0; color: "#57ADD1" }
                }
                Gradient {
                    id: disabledGradient
                    GradientStop { position: 0.0; color: "#E2EDF3" }
                    GradientStop { position: 1.0; color: "#B0BFC4" }
                }
                implicitHeight: 40
                gradient: but_confirm.hovered ? hoveredGradient :
                          but_confirm.enabled ? normalGradient :
                          disabledGradient
                radius: 5
            }

            onClicked: {
                pushanimation.start()
                downloadSource(dialog_apk.fileUrl, dialog_android.fileUrl, dialog_src.fileUrl);
            }

            ScaleAnimator{
                id: pushanimation
                target: but_confirm
                from: 0.9
                to: 1.0
            }
        }
    }
}
