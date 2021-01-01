#ifndef JSONUTIL_H
#define JSONUTIL_H

#include <QObject>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include <QFile>
#include <QDebug>
#include <QCoreApplication>

class JSonUtil : public QObject
{
    Q_OBJECT
public:
    explicit JSonUtil(QObject *parent = nullptr);
    Q_INVOKABLE QJsonArray getJsonArray(const QString & jsonPath);
    Q_INVOKABLE QJsonObject getJsonObject(const QString & jsonPath);
signals:

};

#endif // JSONUTIL_H
