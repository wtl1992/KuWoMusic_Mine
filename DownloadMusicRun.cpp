#include "DownloadMusicRun.h"

DownloadMusicRun::DownloadMusicRun(QString downloadMusicUrl, QString downloadMusicFilePath, QObject *parent)
{
    this->downloadMusicUrl = downloadMusicUrl;
    this->downloadMusicFilePath = downloadMusicFilePath;
}

void DownloadMusicRun::run()
{
    QNetworkAccessManager * networkAccessManager = new QNetworkAccessManager(this);

    QNetworkReply * reply = networkAccessManager->get(QNetworkRequest(QUrl(downloadMusicUrl)));

    QFile file(downloadMusicFilePath);
    bool isOpen = file.open(QIODevice::WriteOnly);

    qDebug() << isOpen;

    QEventLoop loop;

    this->connect(reply,&QNetworkReply::readyRead,[&](){
        file.write(reply->readAll());
    });
    this->connect(reply,&QNetworkReply::finished,[&](){
        file.close();
    });

    loop.exec();
}
