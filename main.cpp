#include "jsonreader.h"
#include "DateGetUtil.h"
#include "JSonUtil.h"
#include "UUIDUtil.h"
#include "MediaPlayer.h"
#include "BackgroundImageReader.h"
#include "NewWindiowSetting.h"
#include "RecommendPageUtil.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QObject>
#include <QIcon>
#include <QWindow>
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setOrganizationName("mine");

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QQmlContext * context = engine.rootContext();

    context->setContextProperty("jsonReader",new JsonReader(context));
    context->setContextProperty("app",&app);
    //获取系统时间
    context->setContextProperty("dateTimeUtil",new DateGetUtil(context));

    //获取jsonUtil的工具类
    context->setContextProperty("jsonUtil",new JSonUtil(context));

    //获取UUID的工具类
    context->setContextProperty("uuidUtil",new UUIDUtil(context));

    //获取mediaPlayer类
    context->setContextProperty("mediaPlayer",new MediaPlayer(context));

    //获取background图片的list
    context->setContextProperty("backgroundImagesReader",new BackgroundImageReader(context));

    //获取新窗口设置的类
    context->setContextProperty("newWindowSetting",new NewWindiowSetting(context));

    //获取RecommendPage的TopN
    context->setContextProperty("recommendPageUtil",new RecommendPageUtil(context));


    qRegisterMetaType<QList<QString> *>("QList<QString> *");

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);


    //设置窗口图标
    app.setWindowIcon(QIcon(":/images/resources/images/window/kuwo.png"));

    return app.exec();
}
