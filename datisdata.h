#ifndef DATISDATA_H
#define DATISDATA_H

#include <QObject>
#include <QString>
#include <QFile>
#include <QTextStream>
#include <QUrl>
#include <QDir>

class DatisData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString datisText READ datisText/* NOTIFY datisTextChanged*/)
    Q_PROPERTY(QString datisVer READ datisVer)
    Q_PROPERTY(QString runway READ runway)
    Q_PROPERTY(QString datisTime READ datisTime)

public:
    explicit DatisData(QObject *parent = nullptr);
//    virtual ~DatisData();
//    DatisData();

    QString datisText() const;
    QString datisVer() const;
    QString runway() const;
    QString datisTime() const;
    Q_INVOKABLE bool readFile(const QUrl &path);
    bool readDatisInfo(const QString &path);
    bool readDatisText(const QString &path);

signals:
//    void datisTextChanged();
    void dataReady();
public slots:

private:
    QString mDatisText;
    QString mDatisVer;
    QString mRunway;
    QString mDatisTime;
};

#endif // DATISDATA_H
