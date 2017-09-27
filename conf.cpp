#include "Conf.h"

Conf::Conf(QObject *parent) : QObject(parent)
  ,mTextSourceUri("")
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
    mTextSourceUri = confObject["textSourceUri"].toString();
    mTabIndex = confObject["tabIndex"].toInt();
//    emit confLoaded();
    return true;
}

QString Conf::datisText() const
{
    return mDatisText;
}

QString Conf::datisVer() const
{
    return mDatisVer;
}

QString Conf::runway() const
{
    return mRunway;
}

bool Conf::readDatisText()
{
    QFile file(mTextSourceUri);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return false;

    QTextStream in(&file);
    in.setCodec("UTF-8");
    QString buf;
    mDatisText = "";
    while (!in.atEnd()) {
//        in >> buf;
        buf = in.readLine();
//        mDatisText.append(buf);
        mDatisText += buf;
        mDatisText += "\n";
    }

    int it = mDatisText.indexOf(QString("通播")) + 2;
//    it += 2;
    mDatisVer = QChar(mDatisText[it]);
//    mRunway = mDatisText[];
    it = mDatisText.indexOf(QString("跑道")) + 2;

    mRunway = QChar(mDatisText[it++]);
    mRunway.append(QChar(mDatisText[it]));
    return true;
}
