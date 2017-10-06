#include "Conf.h"

Conf::Conf(QObject *parent) : QObject(parent)
{

}

Conf::~Conf()
{

}

void Conf::setSourceUrl(const QUrl &a)
{
    mSourceUrl = a;
}

QUrl Conf::sourceUrl() const
{
    return mSourceUrl;
}

void Conf::setTabIndex(const int &a)
{
    mTabIndex = a;
}

int Conf::tabIndex() const
{
    return mTabIndex;
}

bool Conf::saveConf() const
{
    QFile saveFile(QStringLiteral("conf.json"));
    if(!saveFile.open(QIODevice::WriteOnly)) {
        qWarning("无法打开配置文件");
        return false;
    }

    QJsonObject confObject;
    confObject["sourceUri"] = mSourceUrl.toString();
    confObject["tabIndex"] = mTabIndex;
    QJsonDocument saveDoc(confObject);
    saveFile.write(saveDoc.toJson());
    return true;
}

bool Conf::loadConf()
{
    QFile loadFile(QStringLiteral("conf.json"));
    if(!loadFile.open(QIODevice::ReadOnly)) {
        qWarning("无法打开配置文件");
        return false;
    }

    QByteArray saveData = loadFile.readAll();
    QJsonDocument loadDoc(QJsonDocument::fromJson(saveData));
    QJsonObject confObject = loadDoc.object();
    mSourceUrl.setUrl(confObject["sourceUri"].toString());
    mTabIndex = confObject["tabIndex"].toInt();
    return true;
}


