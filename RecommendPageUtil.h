#ifndef RECOMMENDPAGEUTIL_H
#define RECOMMENDPAGEUTIL_H

#include <QObject>
#include <QJsonArray>
#include <QJsonDocument>
#include <QCoreApplication>
#include <QDir>
#include <QStringList>
#include <QDebug>

class RecommendPageUtil : public QObject
{
    Q_OBJECT
public:
    explicit RecommendPageUtil(QObject *parent = nullptr);
    Q_INVOKABLE QJsonArray getTopNPages(QString path);

private:
    QJsonArray topNFilesJsonArray;
signals:

};

#endif // RECOMMENDPAGEUTIL_H
