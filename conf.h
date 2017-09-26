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
    Q_PROPERTY(QString datisText READ datisText NOTIFY datisTextChanged)
    Q_PROPERTY(char datisVer READ datisVer)
    Q_PROPERTY(unsigned runway READ runway)


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
    char datisVer() const;
    unsigned runway() const;

signals:
//    void confLoaded();
public slots:

private:
    QString mTextSourceUri;
    int mTabIndex;
    QString mDatisText;
    char mDatisVer;
    unsigned mRunway;
};

#endif // CONF_H
