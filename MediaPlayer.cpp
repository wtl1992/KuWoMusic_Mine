#include "MediaPlayer.h"

MediaPlayer::MediaPlayer(QObject *parent) : QObject(parent)
{
    this->mediaPlayer = new QMediaPlayer(this);
}

void MediaPlayer::play()
{
    mediaPlayer->play();
    this->connect(mediaPlayer,&QMediaPlayer::positionChanged,this,&MediaPlayer::positionChanged);
    this->connect(mediaPlayer,&QMediaPlayer::durationChanged,this,&MediaPlayer::durationChanged);
}

void MediaPlayer::setPosition(qint64 position)
{
    this->position = position;
}

qint64 MediaPlayer::getPosition()
{
    return this->position;
}

void MediaPlayer::setDuration(qint64 duration)
{
    this->duration = duration;
}

qint64 MediaPlayer::getDuration()
{
    return this->duration;
}

void MediaPlayer::setUrl(QString url)
{
    mediaPlayer->setMedia(QUrl::fromLocalFile(url));
}

void MediaPlayer::pause()
{
    mediaPlayer->pause();
}

void MediaPlayer::start()
{
    mediaPlayer->play();
}

void MediaPlayer::stop()
{
    mediaPlayer->stop();
}

void MediaPlayer::setPos(qint64 pos)
{
    mediaPlayer->setPosition(pos);
}

void MediaPlayer::download(const QString url,QString folder,QString musicName)
{
    qDebug() << url << ";" << musicName;

    QString fileSavePath = folder + "/" + musicName;

    qDebug() << fileSavePath;

    DownloadMusicRun * downloadMusicRun = new DownloadMusicRun(url,fileSavePath.replace("file:///",""));

    QThread * thread = new QThread();

    downloadMusicRun->moveToThread(thread);

    this->connect(thread,&QThread::started,downloadMusicRun,&DownloadMusicRun::run);
    this->connect(this,&MediaPlayer::destroyed,[&](){
        thread->quit();
        thread->wait();
        delete thread;

        delete downloadMusicRun;
    });

    thread->start();
}


void MediaPlayer::positionChanged(qint64 position)
{
    this->position = position;
}

void MediaPlayer::durationChanged(qint64 duration)
{
    this->duration = duration;
}
