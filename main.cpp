#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "myquickitem.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterType<MyQuickItem>("myquickitem",1,0,"MyQuickItem");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
