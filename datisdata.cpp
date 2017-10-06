#include "datisdata.h"

DatisData::DatisData(QObject *parent) : QObject(parent)
{

}

QString DatisData::datisText() const
{
    return mDatisText;
}

QString DatisData::datisVer() const
{
    return mDatisVer;
}

QString DatisData::runway() const
{
    return mRunway;
}

QString DatisData::datisTime() const
{
    return mDatisTime;
}

bool DatisData::readDatisText(const QString &path)
{

//    if (mTextSourceUri.startsWith("ftp"))

    QFile file(QString(path + "Voice.ini"));    // Voice.ini
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return false;

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
//    file.close();
    return true;
}

bool DatisData::readDatisInfo(const QString &path)
{
    QFile file(QString(path + "datis.ini"));    // datis.ini
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return false;

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

bool DatisData::readFile(const QUrl &path)
{
//    QUrl url;
//    url.setScheme("file");
//    url.setUrl(QString(path + "/datis.ini"));

//    QString filePath = path.toLocalFile();
//    QFile file(filePath + "/datis.ini");    // datis.ini
//    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
//        return false;

//    readDatisInfo(file);
//    file.close();

//    QFile file2(QString(filePath + "/Voice.ini"));    // Voice.ini
//    if (!file2.open(QIODevice::ReadOnly | QIODevice::Text))
//        return false;

//    readDatisText(file2);
//    file2.close();
//    emit datisTextChanged(mDatisText);
//    emit datisTextChanged();
    QString filePath;
//    if (path.scheme() == "ftp") {

//    }

    if (path.scheme() == "file") {
        filePath = path.toLocalFile() + '/';
    }
    readDatisInfo(filePath);
    readDatisText(filePath);

//    switch (path.scheme().toLatin1()) {
//    case "ftp":
//        readDatisInfo(filePath);
//        readDatisText(filePath);
//        break;
//    case "file":
//        break;
//    default:
//        return false;
//        break;
//    }

    emit dataReady();
    return true;
}
