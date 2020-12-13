#include "jsonreader.h"

QString JsonReader::SLIDER_PNGS_PATH = QString::fromUtf8("resources/images/sliderPngs");
QList<QString> * JsonReader::imageList = new QList<QString>();
QString JsonReader::LEFT_TEXTAREA_PATH = QString::fromUtf8("resources/leftAreaConfig.json");
QList<QString> * JsonReader::leftAreaTagJsonList = new QList<QString>();;
JsonReader::JsonReader(QObject * parent) : QObject(parent)
{

}


QList<QString> * JsonReader::getSliderPngs(){

    QDir * dir = new QDir(QCoreApplication::applicationDirPath() + "/" + JsonReader::SLIDER_PNGS_PATH);

    QFileInfoList fileInfoList = dir->entryInfoList();

    qDebug() << QCoreApplication::applicationDirPath();

    //遍历获取
    foreach(QFileInfo fileInfo ,dir->entryInfoList())
    {
        qDebug() << fileInfo.absolutePath() + "/" + fileInfo.fileName();
        if (fileInfo.isFile()){
            imageList->append(fileInfo.absolutePath() + "/" + fileInfo.fileName());
        }
    }

    qDebug() << imageList->size();

    return imageList;
}


QString JsonReader::getListByIndex(QList<QString> * list,int index){
    qDebug() << list;
    return list->at(index);
}

int JsonReader::getListSize(QList<QString> * list){
    return list->size();
}

QString JsonReader::getLeftAreaConfigJson(){
    QFile file(QCoreApplication::applicationDirPath() + "/" + LEFT_TEXTAREA_PATH);
    if (file.open(QIODevice::ReadOnly | QIODevice::Text) == false){
        qDebug() << "打开文件失败:" + LEFT_TEXTAREA_PATH;
        exit(-1);
    }

    QTextStream in(&file);
    QString stringBuilder = "";
    QString line = in.readLine();
    while (!line.isNull()) {
        stringBuilder.append(line);
        line = in.readLine();
    }

    return stringBuilder;
}
