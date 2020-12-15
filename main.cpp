#include "jsonreader.h"
#include "dategetutil.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QObject>
#include <QIcon>
#include <QWindow>
int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QQmlContext * context = engine.rootContext();

    context->setContextProperty("jsonReader",new JsonReader());
    context->setContextProperty("app",&app);
    //获取系统时间
    context->setContextProperty("dateTimeUtil",new DateGetUtil());


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
    //获取rootObjects
    QObject * objects = engine.rootObjects().first();
    QWindow * qmlWindow = qobject_cast<QWindow *>(objects);//获取qml在的源窗口

    //qmlWindow->setFlag(Qt::FramelessWindowHint);

    return app.exec();
}
