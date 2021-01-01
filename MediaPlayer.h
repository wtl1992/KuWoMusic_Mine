#ifndef MEDIAPLAYER_H
#define MEDIAPLAYER_H

#include <QObject>
#include <QMediaPlayer>
#include <QFileDialog>
#include <QThread>
#include <QFile>
#include <QIODevice>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include "DownloadMusicRun.h"

class MediaPlayer : public QObject
{
    Q_OBJECT
    Q_PROPERTY(qint64 position READ getPosition WRITE setPosition NOTIFY posChanged);
    Q_PROPERTY(qint64 duration READ getDuration WRITE setDuration NOTIFY durChanged);
public:
    explicit MediaPlayer(QObject *parent = nullptr);

    Q_INVOKABLE void play();

    void setPosition(qint64 position);
    qint64 getPosition();
    void setDuration(qint64 duration);
    qint64 getDuration();

    Q_INVOKABLE void setUrl(QString url);
    Q_INVOKABLE void pause();
    Q_INVOKABLE void start();
    Q_INVOKABLE void stop();
    Q_INVOKABLE void setPos(qint64 pos);

    //下载功能
    Q_INVOKABLE void download(const QString url,QString folder,QString musicName);

private:
    QMediaPlayer * mediaPlayer;
    qint64 position;
    qint64 duration;


signals:
    void posChanged(qint64 pos);
    void durChanged(qint64 duration);

    void threadStart();

    void completeOnMusicDownload();
public slots:
    void positionChanged(qint64 position);
    void durationChanged(qint64 duration);
};

#endif // MEDIAPLAYER_H
