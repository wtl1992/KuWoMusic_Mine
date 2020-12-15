#include "dategetutil.h"

DateGetUtil::DateGetUtil(QObject *parent) : QObject(parent)
{

}

QString DateGetUtil::getDateTimeStr()
{
    QDateTime dateTime = QDateTime::currentDateTime();

    return dateTime.toString("yyyy:MM:dd HH:mm:ss");
}
