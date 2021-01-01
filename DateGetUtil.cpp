#include "DateGetUtil.h"

DateGetUtil::DateGetUtil(QObject *parent) : QObject(parent)
{

}


QString DateGetUtil::getDateTimeStr()
{
    QDateTime dateTime = QDateTime::currentDateTime();

    return dateTime.toString("yyyy:MM:dd HH:mm:ss");
}

QString DateGetUtil::parseTimeStamp(qint64 timestamp)
{
    return QDateTime::fromMSecsSinceEpoch(timestamp).toString("yyyy:MM:dd HH:mm:ss");;
}
