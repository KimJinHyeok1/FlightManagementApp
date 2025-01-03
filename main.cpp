#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQmlContext>
#include "dataModel.h"
#include "apiManager.h"
#include "configParser.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    dataModel dataModel;
    apiManager *apiManager = apiManager::getInstance();
    configParser configParser;

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    QQuickStyle::setStyle("Material");

    //!NOTE: dataModel에서 선언한 QPROPERTY를 QML과 연결
    engine.rootContext()->setContextProperty("DataModel", &dataModel);
    engine.rootContext()->setContextProperty("apiManager", apiManager);
    engine.load(url);
    return app.exec();
}
