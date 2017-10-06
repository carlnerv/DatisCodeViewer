#ifndef DOWNLOADMANAGER_H
#define DOWNLOADMANAGER_H

#include <QObject>

#include <QFile>
#include <QFileInfo>
#include <QList>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QSslError>
//#include <QStringList>
//#include <QTimer>
#include <QUrl>

//class DownloadManager : public QObject
//{
//    Q_OBJECT
//public:
//    explicit DownloadManager(QObject *parent = nullptr);

//signals:

//public slots:
//};
#include <stdio.h>

QT_BEGIN_NAMESPACE
class QSslError;
QT_END_NAMESPACE

QT_USE_NAMESPACE

class DownloadManager: public QObject
{
    Q_OBJECT
//    Q_PROPERTY(bool downStatus READ downStatus NOTIFY downStatusChanged)

    QNetworkAccessManager manager;
    QList<QNetworkReply *> currentDownloads;

public:
    DownloadManager();
    Q_INVOKABLE void doDownload(const QUrl &url);
    QString saveFileName(const QUrl &url);
    bool saveToDisk(const QString &filename, QIODevice *data);

signals:
    void downloadCompleted();


public slots:
//    void execute();
    void downloadFinished(QNetworkReply *reply);
    void sslErrors(const QList<QSslError> &errors);

private:
//    bool downStatus = false;    // downloading:false, downloaded:true
};


#endif // DOWNLOADMANAGER_H
