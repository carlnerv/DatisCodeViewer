#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "Conf.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    Conf conf;
    engine.rootContext()->setContextProperty("conf", &conf);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
