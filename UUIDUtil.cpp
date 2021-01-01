#include "UUIDUtil.h"

UUIDUtil::UUIDUtil(QObject *parent) : QObject(parent)
{

}

QString UUIDUtil::getUUID()
{
    return QUuid::createUuid().toString();
}
