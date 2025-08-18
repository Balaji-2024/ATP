#include "interface.h"
#include <QDebug>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

int main(int argc, char *argv[]) {
  QGuiApplication app(argc, argv);
  Interface interface; // Create an instance of Interface to initialize it
  QQmlApplicationEngine engine;

  engine.rootContext()->setContextProperty("appInterface", &interface);
  // ✅ Add disk import path
  engine.addImportPath("../src/qml/modules");

  engine.load(QUrl(QStringLiteral("qrc:/qml/src/qml/Main.qml")));
  if (engine.rootObjects().isEmpty()) {
    qCritical() << "Failed to load QML.";
    return -1;
  }

  return app.exec();
}
