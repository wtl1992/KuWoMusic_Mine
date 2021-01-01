#include "JSonUtil.h"

JSonUtil::JSonUtil(QObject *parent) : QObject(parent)
{

}

QJsonArray JSonUtil::getJsonArray(const QString &jsonPath)
{
    QFile file(QCoreApplication::applicationDirPath() + "/" + jsonPath);

    bool isOpen = file.open(QIODevice::ReadOnly);

    qDebug() << isOpen;

    QJsonDocument jsonDocument = QJsonDocument::fromJson(file.readAll());

    QJsonArray jsonArray = jsonDocument.array();


    return jsonArray;

}

QJsonObject JSonUtil::getJsonObject(const QString &jsonPath)
{
    QFile file(QCoreApplication::applicationDirPath() + "/" + jsonPath);

    bool isOpen = file.open(QIODevice::ReadOnly);

    qDebug() << isOpen;

    QJsonDocument jsonDocument = QJsonDocument::fromJson(file.readAll());

    QJsonObject jsonObject = jsonDocument.object();

    return jsonObject;
}
