#ifndef NETWORKER_H
#define NETWORKER_H

#include <QObject>

class QNetworkReply;

class NetWorker : public QObject
{
    Q_OBJECT
public:
    explicit NetWorker(QObject *parent = nullptr);

signals:

public slots:
};

#endif // NETWORKER_H
