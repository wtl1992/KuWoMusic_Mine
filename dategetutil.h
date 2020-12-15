#ifndef DATEGETUTIL_H
#define DATEGETUTIL_H

#include <QObject>
#include <QString>
#include <QDateTime>

class DateGetUtil : public QObject
{
    Q_OBJECT
public:
    explicit DateGetUtil(QObject *parent = nullptr);

    Q_INVOKABLE QString getDateTimeStr();

};

#endif // DATEGETUTIL_H
