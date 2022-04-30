#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "selectproject.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    QQmlContext *context = engine.rootContext();

    SelectProject select;

    context->setContextProperty("_select", &select);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    //
    QObject::connect(engine.rootObjects().first(), SIGNAL(downloadApk()),
            &select, SLOT(downloadApk()));

    //
    QObject::connect(engine.rootObjects().first(), SIGNAL(downloadSource()),
            &select, SLOT(downloadSource()));

    QObject::connect(engine.rootObjects().first(), SIGNAL(decompileApk()),
            &select, SLOT(decompileApk()));

    return app.exec();
}
