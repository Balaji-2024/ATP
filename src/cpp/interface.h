#include <QObject>
#include <QSerialPort>
#include <QTimer>
#include <fcntl.h>
#include <unistd.h>

class Interface : public QObject {
  Q_OBJECT
public:
  explicit Interface(QObject *parent = nullptr);
  ~Interface();
  QString LinuxKernalVersion();
  QString averageLoad();
  QString freeMemory();
  QString swapMemory();

  QString GetStdoutFromCommand(QString cmd);

public slots:
  // These slots can be connected to signals from the UI and can return values
  QString cpuInfo();
  QString diskInfo();
  QString memInfo();
  void slot_pingClicked(bool state);
};
