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

QString Conf::datisTime() const
{
    return mDatisTime;
}

void Conf::download(const QString &path, const QString &fileName)
{
    mFtp.get(path, fileName);
    connect(&mFtp, SIGNAL(error(QNetworkReply::NetworkError)), this, SLOT(error(QNetworkReply::NetworkError)));
}

bool Conf::readFile()
{
    QString sourceUri;
    if (!mTextSourceUri.startsWith("ftp"))
        sourceUri = mTextSourceUri;
    else {
        mFtp.setHostPort(mTextSourceUri.mid(5,mTextSourceUri.indexOf('/',6) - 5));
        sourceUri = mTextSourceUri.mid(mTextSourceUri.indexOf('/', 6) - 1);
//        mFtp.get(QString(sourceUri + "datis.ini"), "datis.ini");
//        mFtp.get(QString(sourceUri + "Voice.ini"), "Voice.ini");
        download(QString(sourceUri + "datis.ini"), "datis.ini");
        download(QString(sourceUri + "Voice.ini"), "Voice.ini");
        sourceUri.clear();
    }

    QFile file(QString(sourceUri + "datis.ini"));    // datis.ini
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return false;

    readDatisInfo(file);
    file.close();

    QFile file2(QString(sourceUri + "Voice.ini"));    // Voice.ini
    if (!file2.open(QIODevice::ReadOnly | QIODevice::Text))
        return false;

    readDatisText(file2);
    file2.close();
    return true;
}

bool Conf::readDatisText(QFile &file)
{

//    if (mTextSourceUri.startsWith("ftp"))

//    QFile file(QString(mTextSourceUri + "Voice.ini"));    // Voice.ini
//    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
//        return false;

    QTextStream in(&file);
    in.setCodec("UTF-8");
//    QString buf;
//    mDatisText = "";
//    while (!in.atEnd()) {
////        in >> buf;
//        buf = in.readLine();
////        mDatisText.append(buf);
//        mDatisText += buf;
//        mDatisText += "\n";
//    }
    mDatisText = in.readAll();

//    int it = mDatisText.indexOf(QString("通播")) + 2;
//    it += 2;
//    mDatisVer = QChar(mDatisText[it]);
//    mRunway = mDatisText[];
//    it = mDatisText.indexOf(QString("跑道")) + 2;

//    mRunway = QChar(mDatisText[it++]);
//    mRunway.append(QChar(mDatisText[it]));
    mRunway = mDatisText.mid(mDatisText.indexOf(QString("跑道")) + 2, 2);
    file.close();
    return true;
}

bool Conf::readDatisInfo(QFile &file)
{
//    QFile file(QString(mTextSourceUri + "datis.ini"));    // datis.ini
//    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
//        return false;

    QTextStream in(&file);
    in.setCodec("UTF-8");
    QString buf;
    while (!in.atEnd()) {
//        in >> buf;
        buf = in.readLine();
//        mDatisText.append(buf);
//        mDatisText += buf;
//        mDatisText += "\n";
        if (buf.startsWith("Time"))
            mDatisTime = buf.mid(5);
        if (buf.startsWith("Order"))
            mDatisVer = buf.mid(6);
    }
    file.close();
    return true;
}
