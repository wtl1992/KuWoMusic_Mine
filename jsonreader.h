#ifndef JSONREADER_H
#define JSONREADER_H

#include <QObject>
#include <QString>
#include <QList>
#include <QDir>
#include <QFileInfoList>
#include <QFileInfo>
#include <QDebug>
#include <QGuiApplication>
#include <QFile>

class JsonReader : public QObject
{
    Q_OBJECT
public:
    explicit JsonReader(QObject *parent = nullptr);
    /**
      * @brief getSliderPngs 获取slider的pngs
      * @return
     */
    Q_INVOKABLE QList<QString> * getSliderPngs();

    static QString SLIDER_PNGS_PATH;

    static QList<QString> * imageList;
    static QList<QString> * leftAreaTagJsonList;

    static QString LEFT_TEXTAREA_PATH;

    Q_INVOKABLE QString getListByIndex(QList<QString> *,int index);

    Q_INVOKABLE int getListSize(QList<QString> *);

    Q_INVOKABLE QString getLeftAreaConfigJson();

};

#endif // JSONREADER_H
