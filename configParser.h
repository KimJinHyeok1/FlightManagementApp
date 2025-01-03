#ifndef CONFIGPARSER_H
#define CONFIGPARSER_H
#include <QFile>
#include <QDebug>
#include <QCoreApplication>

class configParser
{

  public:
    explicit configParser()
    {
      QString applicationPath = QCoreApplication::applicationDirPath();
      qDebug() << applicationPath;
      QFile file(applicationPath + "/config.json");
      if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) return;
      while (!file.atEnd())
      {
        QByteArray line = file.readLine();
        qDebug() << line;
      }
    };

  private:

};


#endif // CONFIGPARSER_H
