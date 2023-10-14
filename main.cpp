#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    app.setWindowIcon(QIcon(":/Musiclayer/assets/icons/itunes.png"));

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/MusicPlayer/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
