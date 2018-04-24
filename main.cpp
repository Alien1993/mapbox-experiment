#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#define tokenize(s) t(s)
#define t(s) #s

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    auto context = engine.rootContext();
    context->setContextProperty("MAPBOX_ACCESS_TOKEN", tokenize(MAPBOX_ACCESS_TOKEN));

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
