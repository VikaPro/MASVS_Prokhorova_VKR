import QtQuick 2.12
import QtQuick.Controls 2.5

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    title: qsTr("MASVS")

    signal downloadApk()
    signal downloadSource()
    signal decompileApk()

    // главгная страница с выбором проекта (новый или существующий)
    SelectProject{
        id: selectProject
    }

    // страничка с загрузкой входных данных мобильного приложения
    Download{
        id: downloadWindow
    }

    // страничка для выбора только файла APK для тестирования
    OnlyApk{
        id: onlyApk
    }

    // страничка для выбора файла APK и исходного кода для тестирования
    ApkAndCode{
        id: apkAndCode
    }

    // страничка с выбором комбинации для тестирования приложения
    LevelSec{
        id: levelSec
    }

    // страничка с отчётом по уровню безопасности мобильного приложения
    ReportTest{
        id: reportTestWindow
    }

}
