#ifndef CONF_H
#define CONF_H

#include <QObject>
#include <QString>
#include <QFile>
#include <QJsonObject>
#include <QJsonDocument>
#include <QTextStream>

class Conf : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString textSourceUri READ textSourceUri WRITE setTextSourceUri)
    Q_PROPERTY(int tabIndex READ tabIndex WRITE setTabIndex)
    Q_PROPERTY(QString datisText READ datisText)
    Q_PROPERTY(QString datisVer READ datisVer)
    Q_PROPERTY(QString runway READ runway)


public:
    explicit Conf(QObject *parent = 0);
//    Conf(QObject *parent = 0);
//    conf() ;
    virtual ~Conf() ;
    void setTextSourceUri(const QString &a);
    QString textSourceUri() const;
    void setTabIndex(const int &a);
    int tabIndex() const;
    Q_INVOKABLE bool saveConf() const;
    Q_INVOKABLE bool loadConf();
    Q_INVOKABLE bool readDatisText();
    QString datisText() const;
    QString datisVer() const;
    QString runway() const;

signals:
//    void confLoaded();
public slots:

private:
    QString mTextSourceUri;
    int mTabIndex;
    QString mDatisText;
    QString mDatisVer;
    QString mRunway;
};

#endif // CONF_H
