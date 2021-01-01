#include "RecommendPageUtil.h"

RecommendPageUtil::RecommendPageUtil(QObject *parent) : QObject(parent)
{

}

QJsonArray RecommendPageUtil::getTopNPages(QString path)
{
    QString dir = QCoreApplication::applicationDirPath();
    QString filesPath = dir + "/" + path;

    qDebug() << "===================" << filesPath;

    QDir innerDir(filesPath);

    QStringList filter;
    filter << "*.jpg";

    innerDir.setNameFilters(filter);

    QStringList fileList = innerDir.entryList();

    for (int i=0;i<fileList.size();i++){
        topNFilesJsonArray.append("file:///" + filesPath  + "/" + fileList.at(i));
    }

    qDebug() << "==================="   << fileList.size();

    return topNFilesJsonArray;
}
