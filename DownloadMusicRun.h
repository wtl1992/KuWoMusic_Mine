#ifndef DOWNLOADMUSICRUN_H
#define DOWNLOADMUSICRUN_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QEventLoop>
#include <QDebug>
#include <QFile>
#include <QIODevice>
#include <QMessageBox>

class DownloadMusicRun : public QObject
{
    Q_OBJECT
public:
    explicit DownloadMusicRun(QString downloadMusicUrl,QString downloadMusicFilePath,QObject *parent = nullptr);

    void run();

private:
    QString downloadMusicUrl;
    QString downloadMusicFilePath;
signals:

};

#endif // DOWNLOADMUSICRUN_H
