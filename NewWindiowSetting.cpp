#include "NewWindiowSetting.h"

NewWindiowSetting::NewWindiowSetting(QObject *parent) : QObject(parent)
{

}

void NewWindiowSetting::setWindowIcon(QQuickWindow *quickWindow,QString iconPath)
{
    quickWindow->setIcon(QIcon(iconPath));
}
