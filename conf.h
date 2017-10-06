#ifndef CONF_H
#define CONF_H

#include <QObject>
#include <QString>
#include <QFile>
#include <QJsonObject>
#include <QJsonDocument>
//#include <QTextStream>
#include <QUrl>
//#include <QDir>


class Conf : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QUrl sourceUrl READ sourceUrl WRITE setSourceUrl)
    Q_PROPERTY(int tabIndex READ tabIndex WRITE setTabIndex)

public:
    explicit Conf(QObject *parent = 0);
//    Conf(QObject *parent = 0);
//    conf() ;
    virtual ~Conf() ;
    void setSourceUrl(const QUrl &a);
    QUrl sourceUrl() const;
    void setTabIndex(const int &a);
    int tabIndex() const;

    Q_INVOKABLE bool saveConf() const;
    Q_INVOKABLE bool loadConf();


signals:

public slots:


private:
    QUrl mSourceUrl;
    int mTabIndex;
};

#endif // CONF_H
