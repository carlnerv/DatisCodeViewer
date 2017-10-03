#include <QFileInfo>
#include "ftpmanager.h"

FtpManager::FtpManager(QObject *parent) : QObject(parent)
{

}

void FtpManager::get(const QString &path, const QString &fileName)
{
    QFileInfo info;
    info.setFile(fileName);

    m_file.setFileName(fileName);
    m_file.open(QIODevice::WriteOnly);
//    m_pUrl.setPath(path);
    mSource.setPath(path);

    QNetworkReply *pReply = m_manager.get(QNetworkRequest(mSource));

    connect(pReply, SIGNAL(finished()), this, SLOT(finished()));
//    connect(pReply, SIGNAL(downloadProgress(qint64, qint64)), this, SIGNAL(downloadProgress(qint64, qint64)));
//    connect(pReply, SIGNAL(error(QNetworkReply::NetworkError)), this, SLOT(error(QNetworkReply::NetworkError));
}


void FtpManager::finished()
{
    QNetworkReply *pReply = qobject_cast<QNetworkReply *>(sender());

    if (pReply->error() == QNetworkReply::NoError) {
        m_file.write(pReply->readAll());
        m_file.flush();

    }

    m_file.close();
//    emit downloaded();
    pReply->deleteLater();
}

