#ifndef FTPMANAGER_H
#define FTPMANAGER_H

#include <QUrl>
#include <QFile>
#include <QNetworkReply>
#include <QNetworkAccessManager>

class FtpManager : public QObject
{
    Q_OBJECT

public:
    explicit FtpManager(QObject *parent = nullptr);

    Q_INVOKABLE void get(const QString &path, const QString &fileName);


signals:

public slots:

    void finished();

private:
//    QUrl m_pUrl;
    QUrl mSource;
    QFile m_file;
    QNetworkAccessManager m_manager;
};

#endif // FTPMANAGER_H
