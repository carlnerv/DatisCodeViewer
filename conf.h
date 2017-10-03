#ifndef CONF_H
#define CONF_H

#include <QObject>
//#include <QString>
//#include <QFile>
//#include <QJsonObject>
//#include <QJsonDocument>
//#include <QTextStream>
//#include <QUrl>
//#include <QDir>
//#include "ftpmanager.h"

class Conf : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QUrl datisSourceUrl READ datisSourceUrl WRITE setDatisSourceUrl)
    Q_PROPERTY(int tabIndex READ tabIndex WRITE setTabIndex)
    Q_PROPERTY(QString datisText READ datisText NOTIFY datisTextChanged)
    Q_PROPERTY(QString datisVer READ datisVer)
    Q_PROPERTY(QString runway READ runway)
    Q_PROPERTY(QString datisTime READ datisTime)


public:
    explicit Conf(QObject *parent = 0);
//    Conf(QObject *parent = 0);
//    conf() ;
    virtual ~Conf() ;
    void setDatisSourceUrl(const QUrl &a);
    QUrl datisSourceUrl() const;
    void setTabIndex(const int &a);
    int tabIndex() const;
    bool readDatisText(QFile &file);
    bool readDatisInfo(QFile &file);
    Q_INVOKABLE bool saveConf() const;
    Q_INVOKABLE bool loadConf();
    Q_INVOKABLE bool readLocalFile();
    bool readFile(const QString &path);
//    Q_INVOKABLE void download(const QString &path, const QString &fileName);
    QString datisText() const;
    QString datisVer() const;
    QString runway() const;
    QString datisTime() const;

signals:
//    void confLoaded();
//    void datisTextReady();
    void datisTextChanged();
public slots:
    bool readFtpFile();
//    void error(QNetworkReply::NetworkError error);

private:
    QUrl mDatisSourceUrl;
    int mTabIndex;
    QString mDatisText;
    QString mDatisVer;
    QString mRunway;
    QString mDatisTime;
//    bool mReaded;

//    FtpManager mFtp;
};

#endif // CONF_H
