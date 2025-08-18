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
  void LinuxKernalVersion();
  void averageLoad();
  void freeMemory();
  void swapMemory();
  void ramInfo();
  void diskinfo();
  QString GetStdoutFromCommand(QString cmd);
  Q_INVOKABLE void cpuInfo();
signals:
  void cpuInfoUpdated(const QString &cpuText);
};
