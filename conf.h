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
    Q_PROPERTY(double atisVerFontSize READ atisVerFontSize WRITE setAtisVerFontSize)
    Q_PROPERTY(double runwayFontSize READ runwayFontSize WRITE setRunwayFontSize)
    Q_PROPERTY(double atisTextFontSize READ atisTextFontSize WRITE setAtisTextFontSize)
    Q_PROPERTY(int timerInterval READ timerInterval WRITE setTimerInterval)

public:
    explicit Conf(QObject *parent = 0);
//    Conf(QObject *parent = 0);
//    conf() ;
    virtual ~Conf() ;
    void setSourceUrl(const QUrl &a);
    QUrl sourceUrl() const;
    void setTabIndex(const int &a);
    int tabIndex() const;
    void setAtisVerFontSize(const double &a);
    double atisVerFontSize() const;
    void setRunwayFontSize(const double &a);
    double runwayFontSize() const;
    void setAtisTextFontSize(const double &a);
    double atisTextFontSize() const;
    void setTimerInterval(const int &a);
    int timerInterval() const;

    Q_INVOKABLE bool saveConf() const;
    Q_INVOKABLE bool loadConf();


signals:

public slots:


private:
    QUrl mSourceUrl;
    int mTabIndex;
    double mAtisVerFontSize;
    double mRunwayFontSize;
    double mAtisTextFontSize;
    int mTimerInterval;
};

#endif // CONF_H
