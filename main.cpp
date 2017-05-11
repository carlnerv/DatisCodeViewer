#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QFile>

class conf : public QObject
{
    Q_OBJECT
public:
    conf() {}
    virtual ~conf() {}

    conf()
    {
        QFile file("conf");
        if(!file.exists()) return;

    }

    void setXmlSourceUri(const QString &a)
    {
        xmlSourceUri = a;
    }

    QString getXmlSourceUri() const
    {
        return xmlSourceUri;
    }

    void setTabIndex(const int &a)
    {
        tabIndex = a;
    }

    int getTabIndex() const
    {
        return tabIndex;
    }

    bool saveConf()
    {

    }

private:
    QString xmlSourceUri;
    int tabIndex;
};

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
