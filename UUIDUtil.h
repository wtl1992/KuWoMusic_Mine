#ifndef UUIDUTIL_H
#define UUIDUTIL_H

#include <QObject>
#include <QUuid>

class UUIDUtil : public QObject
{
    Q_OBJECT
public:
    explicit UUIDUtil(QObject *parent = nullptr);

    Q_INVOKABLE QString getUUID();

signals:

};

#endif // UUIDUTIL_H
