#include "BackgroundImageReader.h"

BackgroundImageReader::BackgroundImageReader(QObject *parent) : QObject(parent)
{

}

QJsonArray BackgroundImageReader::getBackgroundImages(QString backgroundImagesDir)
{
    QString dir = QCoreApplication::applicationDirPath();
    QString path = dir + "/" + backgroundImagesDir;

    QDir outerDir(path);

    qDebug() << path;

    QStringList nameFilters;
    nameFilters << "*.jpg" << "*.jpeg";
    QStringList files = outerDir.entryList(nameFilters, QDir::Files|QDir::Readable, QDir::Name);

    qDebug() << files.size();

    for (int i=0;i<files.size();i++){
        jsonArray.append("file:///" + path + "/" + files.at(i));
    }

    return jsonArray;
}
