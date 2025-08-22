#include "interface.h"
#include <iostream>

Interface::Interface(QObject *parent) : QObject(parent) {
  std::cout << "inside interface class constructor" << std::endl;
  //   cpuInfo(); // calling cpuInfo function to get the cpu details
  //   ramInfo();
  //   diskinfo(); // calling diskinfo function to get the disk details
}

Interface::~Interface() {}

QString Interface::cpuInfo() {
  FILE *cpuinfo = fopen("/proc/cpuinfo", "rb"); // opening /proc/cpuinfo to read the cpu details
  char line[4098];
  int count = 0;
  QString model = "";
  QString output = "";

  while (fgets(line, sizeof(line), cpuinfo) != NULL) {
    QString strLine(line);
    if (strLine.contains("processor")) {
      count++;
      output += strLine;
    }
    if (strLine.contains("cpu MHz") || strLine.contains("cpu cores")) {
      output += strLine;
    }
    if (strLine.contains("model name")) {
      model = strLine;
    }
  }
  output += QString("Total CPUs: %1\n").arg(count);
  output += QString("CPU Model: %1\n").arg(model.trimmed());

  fclose(cpuinfo);

  output += QString("The LinuxKernalVersion running on your system : %1\n").arg(this->LinuxKernalVersion());

  output += QString("Average load on system in last 15 minutes : %1\n").arg(this->averageLoad());

  return output;
}

QString Interface::LinuxKernalVersion() {
  FILE *version = fopen("/proc/version", "rb"); // open /proc/version to print the version
  char version1[1024];
  fscanf(version, "Linux\tversion\t%s", version1);
  //   ui->textEdit_Info->append(
  //       QString("\tThe LinuxKernalVersion running on your system : ") +
  //       QString(version1));
  // std::cout << "The LinuxKernalVersion running on your system : " << version1
  // << std::endl;
  //   ui->textEdit_Info->append("");
  //   saveText.append("\n----------------------------------------------------------"
  //                   "---------------------\n");
  //   saveText.append(
  //       QString("\nThe LinuxKernelVersion running on your system : ") +
  //       QString(version1));
  //   saveText.append("\n");
  fclose(version);
  return QString(version1);
}

QString Interface::averageLoad() {
  FILE *avgload = fopen("/proc/loadavg", "rb"); // open /proc/loadavg to print the details
                                                // of the avg load in 15 minutes
  float min5, min10, min15;
  fscanf(avgload, "%f %f %f", &min5, &min10, &min15);
  // ui->textEdit_Info->append( QString( "\t" ) + QString::number( min15 ) );
  // std::cout << "Average load on system in last 15 minutes : " << min15
  // << std::endl;
  // saveText.append( QString( "\t" ) + QString::number( min15 ) );
  fclose(avgload);
  return QString::number(min15);
}

QString Interface::freeMemory() {
  QString freeMem = "";
  FILE *freeMemory = fopen("/proc/meminfo", "rb"); // open proc/meminfo to print the memory details about the system
  char line[1024];
  fgets(line, 1024, freeMemory);
  // ui->textEdit_Info->append(QString("\t") + QString(line).remove('\n'));
  freeMem = QString(line);
  // std::cout << "\t" << QString(line).remove('\n').toStdString() << std::endl;
  // saveText.append(QString("\t") + QString(line));
  fgets(line, 1024, freeMemory);
  // ui->textEdit_Info->append(QString("\t") + QString(line).remove('\n'));
  // std::cout << "\t" << QString(line).remove('\n').toStdString() << std::endl;
  freeMem += QString(line);
  // saveText.append(QString("\t") + QString(line));
  fgets(line, 1024, freeMemory);
  // ui->textEdit_Info->append(QString("\t") + QString(line));
  // std::cout << "\t" << QString(line).remove('\n').toStdString() << std::endl;
  freeMem += QString(line);
  // saveText.append(QString("\t") + QString(line));
  fclose(freeMemory);
  return freeMem; // return the last line read from
}

QString Interface::swapMemory() {
  QString swapMem = "";
  FILE *swapMemory1 = fopen("/proc/meminfo", "rb"); // open /proc/meminfo and /proc/swaps to
                                                    // print the swap memory details
  char a[1024], b[1024];
  char line[1024];
  fgets(line, 1024, swapMemory1);
  while (strstr(line, "SwapTotal") == NULL) {
    fgets(line, 1024, swapMemory1);
  }
  // ui->textEdit_Info->append( QString( "\t" ) + QString( line ) );
  // std::cout << "\t" << QString(line).remove('\n').toStdString() << std::endl;
  swapMem = QString(line).remove('\n');
  // saveText.append( QString( "\t" ) + QString( line ) );
  fclose(swapMemory1);

  FILE *swapMemory2 = fopen("/proc/swaps", "rb");
  int size, used, partition;

  fscanf(swapMemory2, "Filename\t\t\t\tType\t\tSize\tUsed\tPriority\n%s\t\t\t\t%s\t\t%d\t%d\t%d\n", a, b, &size, &used, &partition);
  // ui->textEdit_Info->append( QString( "\tThe total used swap space is : " ) +
  // QString::number( used ) );
  // std::cout << "\tThe total used swap space is : " << used << std::endl;
  swapMem += QString("\n\tThe total used swap space is : ") + QString::number(used);
  // ui->textEdit_Info->append( "\tThe swap partitions and their size : " );
  // std::cout << "\tThe swap partitions and their size : " << std::endl;
  swapMem += "\n\tThe swap partitions and their size :\n ";
  // ui->textEdit_Info->append( QString(
  // "\tFilename\t\t\tType\t\tSize\tUsed\tPriority\n\t" ) + QString( a ) +
  // QString( "\t\t\t" )
  //                            + QString( b ) + QString( "\t\t" ) +
  //                            QString::number( size ) + QString( "\t" ) +
  //                            QString::number( used ) + QString( "\t" ) +
  //                            QString::number( partition ) );
  // std::cout << "\tFilename\t\t\tType\t\tSize\tUsed\tPriority\n\t" << a
  //           << "\t\t\t" << b << "\t\t" << size << "\t" << used << "\t"
  //           << partition << std::endl;

  swapMem += QString("\tFilename:\t%1\n\tType:\t%2\n\tSize:\t%3\n\tUsed:\t%4\n\tPriority:\t%5\n").arg(a).arg(b).arg(size).arg(used).arg(partition);
  // .arg(a, b, size, used, partition);

  // saveText.append( QString( "\n\tThe total used swap space is : " ) +
  // QString::number( used ) );
  //    saveText.append( "\n\tThe swap partitions and their size : ");
  //    saveText.append( QString(
  //    "\n\tFilename\t\t\tType\t\tSize\tUsed\tPriority\n\t" ) + QString( a ) +
  //    QString( "\t\t\t" )
  //                               + QString( b ) + QString( "\t\t" ) +
  //                               QString::number( size ) + QString( "\t" ) +
  //                               QString::number( used ) +
  //                                QString( "\t" ) + QString::number( partition
  //                                ) );
  fclose(swapMemory2);
  return swapMem; // return the last line read from
}

QString Interface::memInfo() {
  QString output = "";

  // ui->textEdit_Info->append( " Total usable and free memory in the system : "
  // );
  // std::cout << "Total usable and free memory in the system : " << std::endl;
  output += "Total usable and free memory in the system : \n";
  // saveText.append( "\nTotal usable and free memory in the system : \n" );
  output += this->freeMemory();

  // ui->textEdit_Info->append( "Details about swap memory : \n" );
  std::cout << "Details about swap memory : " << std::endl;
  output += "\n\nDetails about swap memory : \n";
  // saveText.append( "\nDetails about swap memory : \n" );
  output += this->swapMemory();

  // ui->textEdit_Info->setTextColor( QColor( Qt::green ) );
  // ui->textEdit_Info->append( "\n\nMemory Test
  // ...........................Passed\n" ); saveText.append( "\n\nMemory Test
  // ...........................Passed\n"  ); saveSText.append( "\n\nMemory Test
  // ...........................Passed\n"  ); ui->textEdit_Info->setTextColor(
  // QColor( Qt::white ) );

  // ui->textEdit_Info->show();
  // ui->pushButton_clear->show();
  return output; // return the output string containing memory details
}

QString Interface::diskInfo() {

  QString output = "";
  output.append("\n\t DIP Computer Disk Details : ");
  // std::cout << "\n\tCCU Computer Disk Details : " << std::endl;

  QString str;
  str.clear();
  str = this->GetStdoutFromCommand("fdisk -l");

  QStringList list1 = str.split('\n');
  for (int i = 0; i < list1.count(); i++) {
    QStringList list2 = list1.at(i).split(' ');
    int div = 0;
    for (int j = 0; j < list2.count(); j++) {
      //   if (list2.at(j) != NULL) {
      if (!list2.at(j).isEmpty()) {
        div++;
        if (div == 1 && i != 1)
          output.append(list2.at(j) + "\t\t");
        else
          output.append(list2.at(j) + "\t");
      }
    }
    output.append("\n");
  }

  // ui->textEdit_Info->append( output.toStdString().c_str() );
  // std::cout << output.toStdString() << std::endl;
  // ui->textEdit_Info->setTextColor( QColor( Qt::green ) );
  // ui->textEdit_Info->append( "\n\nDISK Test
  // ...........................Passed\n" ); ui->textEdit_Info->setTextColor(
  // QColor( Qt::white ) );

  // saveText.append( output.toStdString().c_str() );
  // saveText.append( "\n\nDISK Test ...........................Passed\n"  );
  // saveSText.append( "\n\nDISK Test ...........................Passed\n"  );

  // ui->textEdit_Info->show();
  // ui->pushButton_clear->show();
  return output;
}

QString Interface::GetStdoutFromCommand(QString cmd) {
  QString data;
  FILE *stream;
  const int max_buffer = 256;
  char buffer[max_buffer];
  cmd.append(" 2>&1");

  stream = popen(cmd.toStdString().c_str(), "r");
  if (stream) {
    while (!feof(stream)) {
      if (fgets(buffer, max_buffer, stream) != NULL) {
        data.append(buffer);
      }
    }
    pclose(stream);
  }
  return data;
}

void Interface::slot_pingClicked(bool state) {
  // Q_UNUSED(state);
  // QString ipStr;
  // int timeout;
  // if (cBit) {
  //   ipStr = ui->lineEdit_cBIT_Eth->text();
  //   timeout = 5;
  // } else {
  //   ipStr = ui->textEdit_pingIP->toPlainText();
  //   timeout = ui->spinBox_pingTO->value();
  // }

  // //    QString command = QString( "ping -c1 -w1 -I" ) + ui->comboBox_ifName->currentText() + QString(" ") + ipStr;
  // QString command = QString("ping -c1 -w1") + QString(" ") + ipStr;

  // int count = 0;
  // saveText.append(QString("\n Pinging To Remote System IP:") + ipStr + QString("\n"));
  // bool flag = true;
  // while (1) {
  //   if (count >= timeout)
  //     break;

  //   QString str;
  //   str.clear();
  //   str = this->GetStdoutFromCommand(command);

  //   ui->textEdit_Info->append(str);
  //   saveText.append(str);
  //   sleep(1);
  //   count++;
  //   qApp->processEvents();
  //   if (str.contains("Destination Host Unreachable") || str.contains("100% packet loss") || str.contains("Network is unreachable") ||
  //       str.contains("Name or service not known"))
  //     flag = false;
  // }
  // if (flag) {
  //   ui->textEdit_Info->setTextColor(QColor(Qt::green));
  //   ui->textEdit_Info->append("\n\nNetwork Test ...........................Passed\n");
  //   saveText.append("\n\nNetwork Test ...........................Passed\n");
  //   saveSText.append("\n\nNetwork Test ...........................Passed\n");
  //   ui->textEdit_Info->setTextColor(QColor(Qt::white));
  // } else {
  //   ui->textEdit_Info->setTextColor(QColor(Qt::darkRed));
  //   ui->textEdit_Info->append("\n\nNetwork Test ...........................Failed\n");
  //   saveText.append("\n\nNetwork Test ...........................Failed\n");
  //   saveSText.append("\n\nNetwork Test ...........................Failed\n");
  //   ui->textEdit_Info->setTextColor(QColor(Qt::white));
  // }
  // qApp->processEvents();
}