#ifndef GLXGEARITEM_H
#define GLXGEARITEM_H

#include <QProcess>
#include <QQuickItem>

class GlxGearItem : public QQuickItem {
  Q_OBJECT

public:
  GlxGearItem();
  ~GlxGearItem();
  Q_INVOKABLE void launchGlxGears();

protected:
  void componentComplete() override;

private:
  bool gearsLaunched = false;
  QProcess *glxProcess = nullptr;
};

#endif // GLXGEARITEM_H
