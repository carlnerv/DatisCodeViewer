#include "Conf.h"

Conf::Conf(QObject *parent) : QObject(parent)
  ,mXmlSourceUri("")
  ,mTabIndex(0)
{

}

Conf::~Conf()
{

}

void Conf::setTextSourceUri(const QString &a)
{
    mTextSourceUri = a;
}

QString Conf::textSourceUri() const
{
    return mTextSourceUri;
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
    confObject["textSourceUri"] = mTextSourceUri;
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

QString Conf::datisText()
{
    return mDatisText;
}

char Conf::datisVer()
{
    return mDatisVer;
}

unsigned Conf::runway()
{
    return mRunway;
}

bool Conf::readDatisText()
{
    QFile file(mTextSourceUri);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return;

    QTextStream in(&file);
    in.setCodec("UTF-8");
    in >> mDatisText;
    mDatisVer = mDatisText[mDatisText.indexOf("通播")+2];
//    mRunway = mDatisText[];
}
