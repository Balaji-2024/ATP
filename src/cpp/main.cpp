#include <QDebug>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    // ✅ Add disk import path
    engine.addImportPath("../src/qml/modules");

    engine.load(QUrl(QStringLiteral("qrc:/qml/src/qml/Main.qml")));
    if (engine.rootObjects().isEmpty()) {
        qCritical() << "Failed to load QML.";
        return -1;
    }

    return app.exec();
}
