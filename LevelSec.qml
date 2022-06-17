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

    // тёмный голубой цвет
    Gradient {
        id: blue_normal_Gradient
        GradientStop { position: 0.0; color: "#99E1FF" }
        GradientStop { position: 1.0; color: "#57ADD1" }
    }
    // светлый голубой цвет
    Gradient {
        id: blue_hovered_Gradient
        GradientStop { position: 0.0; color: "#D7F3FE" }
        GradientStop { position: 1.0; color: "#99E1FF" }
    }
    // тёмный зелёный цвет
    Gradient {
        id: green_normal_Gradient
        GradientStop { position: 0.0; color: "#99FFBE" }
        GradientStop { position: 1.0; color: "#57D181" }
    }
    // светлый зелёный цвет
    Gradient {
        id: green_hovered_Gradient
        GradientStop { position: 0.0; color: "#D7FEE5" }
        GradientStop { position: 1.0; color: "#99FFBE" }
    }

    ColumnLayout{       
        height: parent.height
        width: 0.9 * parent.width
        anchors.centerIn: parent

        Label {
            id: info_level
            text: "В стандарте MASVS представлены четыре возможные комбинации проверки приложения. Для получения дополнительной информации наведите курсор на интересующую карточку, а для выбора уровня - кликните на неё"
            color: "#ffffff"
            lineHeight: 1.1
            font.pointSize: 12
            wrapMode: Text.WordWrap
            //font.capitalization: Font.AllUppercase
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 0.3 * parent.height
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        RowLayout{
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: 0.3 * parent.height
            spacing: 20

            // Кнопка уровня L1
            MouseArea{
                id: but_L1
                Layout.preferredWidth: 0.2 * parent.width
                Layout.preferredHeight: 0.6 * parent.height
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                // фон для карточки
                Rectangle{
                    id: but_L1_back
                    anchors.fill: parent
                    radius: 5
                    gradient: blue_normal_Gradient
                }

                Label {
                    text: "L1"
                    anchors.fill: parent
                    font.pointSize: 15
                    font.weight: Font.DemiBold
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }

                // изменение цвета карточки при наведении
                hoverEnabled: true
                onEntered: {
                    info_level.text = "Первый уровень (L1) - подходит для базового обеспечения безопасности приложений, не усложняя процесс разработки"
                    if(varItem.aLevel == "L1"){
                        but_L1_back.gradient = green_hovered_Gradient
                    }
                    else{
                        but_L1_back.gradient = blue_hovered_Gradient
                    }
                }
                onExited: {
                    info_level.text = "В стандарте MASVS представлены четыре возможные комбинации проверки приложения. Для получения дополнительной информации наведите курсор на интересующую карточку, а для выбора уровня - кликните на неё"
                    if(varItem.aLevel == "L1"){
                        but_L1_back.gradient = green_normal_Gradient
                    }
                    else{
                        but_L1_back.gradient = blue_normal_Gradient
                    }
                }
                onClicked: {
                    pushanimation_L1.start()
                    but_start.enabled = true
                    varItem.aLevel = "L1"
                    // активный уровень делаем зелёным, остальные голубым
                    but_L1_back.gradient = green_normal_Gradient
                    but_L2_back.gradient = blue_normal_Gradient
                    but_L1R_back.gradient = blue_normal_Gradient
                    but_L2R_back.gradient = blue_normal_Gradient
                }

                ScaleAnimator{
                    id: pushanimation_L1
                    target: but_L1
                    from: 0.9
                    to: 1.0
                }
            }

            // Кнопка уровня L2
            MouseArea{
                id: but_L2
                Layout.preferredWidth: 0.2 * parent.width
                Layout.preferredHeight: 0.6 * parent.height
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                // фон для карточки
                Rectangle{
                    id: but_L2_back
                    anchors.fill: parent
                    radius: 5
                    gradient: blue_normal_Gradient
                }

                Label {
                    text: "L2"
                    anchors.fill: parent
                    font.pointSize: 15
                    font.weight: Font.DemiBold
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }

                // изменение цвета карточки при наведении
                hoverEnabled: true
                onEntered: {
                    info_level.text = "Второй уровень (L2) - подходит для приложений, обрабатывающих ПДн пользователей и другие чувствительные данные"
                    if(varItem.aLevel == "L2"){
                        but_L2_back.gradient = green_hovered_Gradient
                    }
                    else{
                        but_L2_back.gradient = blue_hovered_Gradient
                    }
                }
                onExited: {
                    info_level.text = "В стандарте MASVS представлены четыре возможные комбинации проверки приложения. Для получения дополнительной информации наведите курсор на интересующую карточку, а для выбора уровня - кликните на неё"
                    if(varItem.aLevel == "L2"){
                        but_L2_back.gradient = green_normal_Gradient
                    }
                    else{
                        but_L2_back.gradient = blue_normal_Gradient
                    }
                }
                onClicked: {
                    pushanimation_L2.start()
                    but_start.enabled = true
                    varItem.aLevel = "L2"
                    // активный уровень делаем зелёным, остальные голубым
                    but_L1_back.gradient = blue_normal_Gradient
                    but_L2_back.gradient = green_normal_Gradient
                    but_L1R_back.gradient = blue_normal_Gradient
                    but_L2R_back.gradient = blue_normal_Gradient
                }

                ScaleAnimator{
                    id: pushanimation_L2
                    target: but_L2
                    from: 0.9
                    to: 1.0
                }
            }

            // Кнопка уровня L1 + R
            MouseArea{
                id: but_L1R
                Layout.preferredWidth: 0.2 * parent.width
                Layout.preferredHeight: 0.6 * parent.height
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                // фон для карточки
                Rectangle{
                    id: but_L1R_back
                    anchors.fill: parent
                    radius: 5
                    gradient: blue_normal_Gradient
                }

                Label {
                    text: "L1 + R"
                    anchors.fill: parent
                    font.pointSize: 15
                    font.weight: Font.DemiBold
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }

                // изменение цвета карточки при наведении
                hoverEnabled: true
                onEntered: {
                    info_level.text = "Первый уровень совместно с третьим (L1 + R) - подходит для приложений, представляющих интеллектуальную ценность, например для игр"
                    if(varItem.aLevel == "L1 + R"){
                        but_L1R_back.gradient = green_hovered_Gradient
                    }
                    else{
                        but_L1R_back.gradient = blue_hovered_Gradient
                    }
                }
                onExited: {
                    info_level.text = "В стандарте MASVS представлены четыре возможные комбинации проверки приложения. Для получения дополнительной информации наведите курсор на интересующую карточку, а для выбора уровня - кликните на неё"
                    if(varItem.aLevel == "L1 + R"){
                        but_L1R_back.gradient = green_normal_Gradient
                    }
                    else{
                        but_L1R_back.gradient = blue_normal_Gradient
                    }
                }
                onClicked: {
                    pushanimation_L1R.start()
                    but_start.enabled = true
                    varItem.aLevel = "L1 + R"
                    // активный уровень делаем зелёным, остальные голубым
                    but_L1_back.gradient = blue_normal_Gradient
                    but_L2_back.gradient = blue_normal_Gradient
                    but_L1R_back.gradient = green_normal_Gradient
                    but_L2R_back.gradient = blue_normal_Gradient
                }

                ScaleAnimator{
                    id: pushanimation_L1R
                    target: but_L1R
                    from: 0.9
                    to: 1.0
                }
            }

            // Кнопка уровня L2 + R
            MouseArea{
                id: but_L2R
                Layout.preferredWidth: 0.2 * parent.width
                Layout.preferredHeight: 0.6 * parent.height
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                // фон для карточки
                Rectangle{
                    id: but_L2R_back
                    anchors.fill: parent
                    radius: 5
                    gradient: blue_normal_Gradient
                }

                Label {
                    text: "L2 + R"
                    anchors.fill: parent
                    font.pointSize: 15
                    font.weight: Font.DemiBold
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }

                // изменение цвета карточки при наведении
                hoverEnabled: true
                onEntered: {
                    info_level.text = "Второй уровень совместно с третьим (L2 + R) - подходит для защиты приложений даже на укорененных с помощью Root или Jailbreak устройствах"
                    if(varItem.aLevel == "L2 + R"){
                        but_L2R_back.gradient = green_hovered_Gradient
                    }
                    else{
                        but_L2R_back.gradient = blue_hovered_Gradient
                    }
                }
                onExited: {
                    info_level.text = "В стандарте MASVS представлены четыре возможные комбинации проверки приложения. Для получения дополнительной информации наведите курсор на интересующую карточку, а для выбора уровня - кликните на неё"
                    if(varItem.aLevel == "L2 + R"){
                        but_L2R_back.gradient = green_normal_Gradient
                    }
                    else{
                        but_L2R_back.gradient = blue_normal_Gradient
                    }
                }
                onClicked: {
                    pushanimation_L2R.start()
                    but_start.enabled = true
                    varItem.aLevel = "L2 + R"
                    // активный уровень делаем зелёным, остальные голубым
                    but_L1_back.gradient = blue_normal_Gradient
                    but_L2_back.gradient = blue_normal_Gradient
                    but_L1R_back.gradient = blue_normal_Gradient
                    but_L2R_back.gradient = green_normal_Gradient
                }

                ScaleAnimator{
                    id: pushanimation_L2R
                    target: but_L2R
                    from: 0.9
                    to: 1.0
                }
            }
        }


        Button{
            id: but_start
            enabled: false
            text: "Начать тестирование!"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.bottomMargin: 0.05 * parent.height

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
                gradient: but_start.hovered ? hoveredGradient :
                          but_start.enabled ? normalGradient :
                          disabledGradient
                radius: 5
            }

            onClicked: {
                pushanimation.start()
                levelSec.visible = false
                pageAutoTest.visible = true
                writeLevel(varItem.aLevel); // записываем уровень безопасности в файл
                autoTest(varItem.aLevel);   // запускаем автоматические тесты
            }

            ScaleAnimator{
                id: pushanimation
                target: but_start
                from: 0.9
                to: 1.0
            }
        }
    }
}
