#ifndef NEWWINDIOWSETTING_H
#define NEWWINDIOWSETTING_H

#include <QObject>
#include <QQuickWindow>

class NewWindiowSetting : public QObject
{
    Q_OBJECT
public:
    explicit NewWindiowSetting(QObject *parent = nullptr);
    Q_INVOKABLE void setWindowIcon(QQuickWindow * quickWindow,QString iconPath);
signals:

};

#endif // NEWWINDIOWSETTING_H
