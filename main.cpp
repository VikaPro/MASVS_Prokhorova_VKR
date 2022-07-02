#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "selectproject.h"
#include "autotesting.h"
#include "usertesting.h"

#include "projectsmodel.h"
#include "reportsmodel.h"
#include "permissionmodel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    // Задаём, чтобы модуль не выводил ошибок, произвольные данные
    app.setOrganizationName("MASVS"); //для QFileDialog "Если приложение запускается с помощью пользовательской
    app.setOrganizationDomain("masvs.com");    //функции C++ main (), рекомендуется задать имя, организацию и домен
                                                //для управления расположением параметров приложения."

    QQmlApplicationEngine engine;

    QQmlContext *context = engine.rootContext();

    SelectProject select;

    AutoTesting auto_test;

    UserTesting user_test(&select);

    context->setContextProperty("_select", &select);

    context->setContextProperty("_auto", &auto_test);

    context->setContextProperty("_user", &user_test);

    context->setContextProperty("_report", select.reports_model);

    context->setContextProperty("_projects", select.projects_model);

    context->setContextProperty("_permission", auto_test.permission_model);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    //
    QObject::connect(engine.rootObjects().first(), SIGNAL(checkNameProject(QString)),
            &select, SLOT(checkNameProject(QString)));

    //
    QObject::connect(engine.rootObjects().first(), SIGNAL(downloadApk(QString)),
            &select, SLOT(downloadApk(QString)));

    //
    QObject::connect(engine.rootObjects().first(), SIGNAL(downloadSource(QString, QString, QString)),
            &select, SLOT(downloadSource(QString, QString, QString)));

    QObject::connect(engine.rootObjects().first(), SIGNAL(writeLevel(QString)),
            &select, SLOT(writeLevel(QString)));

    QObject::connect(engine.rootObjects().first(), SIGNAL(setListProject()),
            &select, SLOT(setListProject()));

    QObject::connect(engine.rootObjects().first(), SIGNAL(showReport(QString)),
            &select, SLOT(showReport(QString)));

    QObject::connect(engine.rootObjects().first(), SIGNAL(checkPercent(QString)),
            &select, SLOT(checkPercent(QString)));

    // другой класс
    QObject::connect(engine.rootObjects().first(), SIGNAL(autoTest(QString)),
            &auto_test, SLOT(autoTest(QString)));

    QObject::connect(engine.rootObjects().first(), SIGNAL( resultMinPermissions(QString)),
            &auto_test, SLOT(resultMinPermissions(QString)));

    // ещё один класс
    QObject::connect(engine.rootObjects().first(), SIGNAL(userTest()),
            &user_test, SLOT(userTest()));

    QObject::connect(engine.rootObjects().first(), SIGNAL(resultUser(QString, QString, QString, int)),
            &user_test, SLOT(resultUser(QString, QString, QString, int)));

    QObject::connect(engine.rootObjects().first(), SIGNAL(incompleteChecks(int)),
            &user_test, SLOT(incompleteChecks(int)));




    return app.exec();
}
