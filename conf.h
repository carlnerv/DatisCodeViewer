#ifndef CONF_H
#define CONF_H

#include <QObject>
#include <QString>
#include <QFile>
#include <QJsonObject>
#include <QJsonDocument>

class Conf : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString xmlSourceUri READ xmlSourceUri WRITE setXmlSourceUri)
    Q_PROPERTY(int tabIndex READ tabIndex WRITE setTabIndex)

public:
    explicit Conf(QObject *parent = 0);
//    Conf(QObject *parent = 0);
//    conf() ;
    virtual ~Conf() ;
    void setXmlSourceUri(const QString &a);
    QString xmlSourceUri() const;
    void setTabIndex(const int &a);
    int tabIndex() const;
    Q_INVOKABLE bool saveConf() const;
    Q_INVOKABLE bool loadConf();

signals:
//    void confLoaded();
public slots:

private:
    QString mXmlSourceUri;
    int mTabIndex;
};

#endif // CONF_H
