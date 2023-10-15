#include <QGuiApplication>
#include <QIcon>
#include <QQmlApplicationEngine>

#include "PlayerController.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    app.setWindowIcon(QIcon(":/Musiclayer/assets/icons/itunes.png"));

    PlayerController *playerController = new PlayerController(&app);
    qmlRegisterSingletonInstance("com.company.PlayerController",
                                 1,
                                 0,
                                 "PlayerController",
                                 playerController);

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/MusicPlayer/Main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
