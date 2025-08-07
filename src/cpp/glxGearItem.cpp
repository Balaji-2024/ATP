#include "glxGearItem.h"

#include <QDebug>
#include <QQuickWindow>
#include <X11/Xlib.h>
#include <unistd.h> // for usleep

GlxGearItem::GlxGearItem() {
  setFlag(ItemHasContents, false);

  connect(this, &QQuickItem::windowChanged, this, [this](QQuickWindow *win) {
    if (win) {
      qDebug() << "Window ready, launching glxgears.";
      launchGlxGears();
    }
  });
}

GlxGearItem::~GlxGearItem() {
  if (glxProcess) {
    glxProcess->terminate();
    glxProcess->waitForFinished(1000);
    delete glxProcess;
  }
}

void GlxGearItem::componentComplete() {
  QQuickItem::componentComplete();
  if (window()) {
    qDebug() << "Window already available, launching glxgears.";
    launchGlxGears();
  }
}

void GlxGearItem::launchGlxGears() {
  //   if (gearsLaunched)
  //     return;

  //   gearsLaunched = true;
  if (!window()) {
    qWarning() << "Window is null, cannot launch glxgears.";
    return;
  }

  WId winId = window()->winId(); // Native X11 window ID
  qDebug() << "Using winId:" << winId;

  // Confirm X11 display is available
  Display *display = XOpenDisplay(nullptr);
  if (!display) {
    qWarning() << "Cannot open X11 display.";
    return;
  }
  XCloseDisplay(display); // Optional, just a check

  // Create the glxgears process
  glxProcess = new QProcess(this);
  QStringList args = {"-window-id",
                      QString::number(static_cast<qulonglong>(winId))};

  glxProcess->setProgram("glxgears");
  glxProcess->setArguments(args);

  connect(glxProcess, &QProcess::errorOccurred, this,
          [](QProcess::ProcessError err) {
            qWarning() << "glxgears process error:" << err;
          });

  glxProcess->start();
  if (!glxProcess->waitForStarted()) {
    qWarning() << "Failed to start glxgears process.";
  }
}
