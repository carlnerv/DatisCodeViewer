#ifndef CONF_H
#define CONF_H

#include <QObject>
#include <QString>
#include <QFile>
#include <QJsonObject>
#include <QJsonDocument>
#include <QTextStream>
#include "ftpmanager.h"

class Conf : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString textSourceUri READ textSourceUri WRITE setTextSourceUri)
    Q_PROPERTY(int tabIndex READ tabIndex WRITE setTabIndex)
    Q_PROPERTY(QString datisText READ datisText)
    Q_PROPERTY(QString datisVer READ datisVer)
    Q_PROPERTY(QString runway READ runway)
    Q_PROPERTY(QString datisTime READ datisTime)


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
    Q_INVOKABLE bool readFile();
    Q_INVOKABLE bool readDatisText(QFile &file);
    Q_INVOKABLE bool readDatisInfo(QFile &file);
    Q_INVOKABLE void download(const QString &path, const QString &fileName);
    QString datisText() const;
    QString datisVer() const;
    QString runway() const;
    QString datisTime() const;

signals:
//    void confLoaded();
public slots:

private:
    QString mTextSourceUri;
    int mTabIndex;
    QString mDatisText;
    QString mDatisVer;
    QString mRunway;
    QString mDatisTime;

    FtpManager mFtp;
};

#endif // CONF_H
