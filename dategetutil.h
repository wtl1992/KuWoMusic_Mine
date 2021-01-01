#ifndef DATEGETUTIL_H
#define DATEGETUTIL_H

#include <QObject>
#include <QDateTime>

class DateGetUtil : public QObject
{
    Q_OBJECT
public:
    explicit DateGetUtil(QObject *parent = nullptr);

    Q_INVOKABLE QString getDateTimeStr();

    Q_INVOKABLE QString parseTimeStamp(qint64 timestamp);
};

#endif // DATEGETUTIL_H
