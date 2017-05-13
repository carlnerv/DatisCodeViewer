#include "Conf.h"

Conf::Conf(QObject *parent) : QObject(parent)
  ,mXmlSourceUri("")
  ,mTabIndex(0)
{

}

Conf::~Conf()
{

}

void Conf::setXmlSourceUri(const QString &a)
{
    mXmlSourceUri = a;
}

QString Conf::xmlSourceUri() const
{
    return mXmlSourceUri;
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
    confObject["xmlSourceUri"] = mXmlSourceUri;
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
    mXmlSourceUri = confObject["xmlSourceUri"].toString();
    mTabIndex = confObject["tabIndex"].toInt();
//    emit confLoaded();
    return true;
}
