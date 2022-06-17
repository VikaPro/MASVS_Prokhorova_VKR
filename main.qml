import QtQuick 2.12
import QtQuick.Controls 2.5

ApplicationWindow {
    id: window
    visible: true
    width: 640
    height: 480
    minimumWidth: 520
    minimumHeight: 390
    title: qsTr("MASVS")

    signal checkNameProject(string name);
    signal downloadApk(string apk);
    signal downloadSource(string apk, string apk_dir, string src);
    signal writeLevel(string level);
    signal setListProject();
    signal showReport(string name);
    signal autoTest(string level);
    signal userTest();
    signal incompleteChecks(int index);

    signal resultUser(string number, string description, string result, int index)

    signal resultMinPermissions(string result);

    // главгная страница с выбором проекта (новый или существующий)
    SelectProject{
        id: selectProject
    }

    // страничка с вводом имени для нового проекта
    NameProject{
        id: nameProject
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


    // страничка со всеми существующими проектами
    AllProjects{
        id: allProjects
    }

    // страничка с отчётом по конкретному проекту
    ReadReport{
        id: readReport
    }

    // страничка с отображением процесса автоматического тестирования
    PageAutoTest{
        id: pageAutoTest
    }

    // страничка с шаблоном для каждой ручной проверки, проводимой пользователем
    PageUserTest{
        id: pageUserTest
    }

    // страничка с шаблоном для каждой ручной проверки, проводимой пользователем
    PermissionPage{
        id: permissionPage
    }

}
