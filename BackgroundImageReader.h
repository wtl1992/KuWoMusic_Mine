#ifndef BACKGROUNDIMAGEREADER_H
#define BACKGROUNDIMAGEREADER_H

#include <QObject>
#include <QList>
#include <QCoreApplication>
#include <QDir>
#include <QDebug>
#include <QJsonDocument>
#include <QJsonArray>

class BackgroundImageReader : public QObject
{
    Q_OBJECT
public:
    explicit BackgroundImageReader(QObject *parent = nullptr);

    Q_INVOKABLE QJsonArray getBackgroundImages(QString backgroundImagesDir);

private:
    QJsonArray jsonArray;
signals:

};

#endif // BACKGROUNDIMAGEREADER_H
