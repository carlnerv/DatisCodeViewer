#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "conf.h"
#include "downloadmanager.h"
#include "datisdata.h"

#define QT_NO_SSL


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    Conf conf;
    DatisData dd;
    DownloadManager dm;

    engine.rootContext()->setContextProperty("conf", &conf);
    engine.rootContext()->setContextProperty("downloadManager", &dm);
    engine.rootContext()->setContextProperty("datisData", &dd);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
