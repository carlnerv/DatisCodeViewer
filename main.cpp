#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "Conf.h"
//#include "ftpmanager.h"


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

//    Conf conf;
//    FtpManager mFtp;

//    QObject::connect(&mFtp, SIGNAL(downloaded()), &conf, SLOT(readFtpFile()));

//    engine.rootContext()->setContextProperty("conf", &conf);
//    engine.rootContext()->setContextProperty("mFtp", &mFtp);

    qmlRegisterType<Conf>("com.mycompany.conf", 1, 0, "Conf");
//    qmlRegisterType<FtpManager>("com.mycompany.ftpmanager", 1, 0, "FtpManager");

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
