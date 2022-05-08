#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "selectproject.h"
#include "projectsmodel.h"

#include "autotesting.h"
#include "permissionmodel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    QQmlContext *context = engine.rootContext();

    SelectProject select;

    AutoTesting auto_test;

    context->setContextProperty("_select", &select);

    context->setContextProperty("_auto", &auto_test);

    context->setContextProperty("_projects", select.projects_model);

    context->setContextProperty("_permission", auto_test.permission_model);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;


    //
    QObject::connect(engine.rootObjects().first(), SIGNAL(checkNameProject(QString)),
            &select, SLOT(checkNameProject(QString)));

    //
    QObject::connect(engine.rootObjects().first(), SIGNAL(downloadApk()),
            &select, SLOT(downloadApk()));

    //
    QObject::connect(engine.rootObjects().first(), SIGNAL(downloadSource()),
            &select, SLOT(downloadSource()));

    QObject::connect(engine.rootObjects().first(), SIGNAL(decompileApk()),
            &select, SLOT(decompileApk()));

    QObject::connect(engine.rootObjects().first(), SIGNAL(setListProject()),
            &select, SLOT(setListProject()));

    QObject::connect(engine.rootObjects().first(), SIGNAL(showReport(QString)),
            &select, SLOT(showReport(QString)));


    // другой файл
    QObject::connect(engine.rootObjects().first(), SIGNAL(autoTest(QString)),
            &auto_test, SLOT(autoTest(QString)));

    QObject::connect(engine.rootObjects().first(), SIGNAL( resultMinPermissions(QString)),
            &auto_test, SLOT( resultMinPermissions(QString)));

    // потом удалить
    /*QObject::connect(engine.rootObjects().first(), SIGNAL(endTimerTest(QString, QString, QString)),
            &auto_test, SLOT(endTimerTest(QString, QString, QString)));*/

    return app.exec();
}
