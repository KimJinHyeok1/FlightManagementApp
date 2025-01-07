#ifndef CONFIGPARSER_H
#define CONFIGPARSER_H
#include <QFile>
#include <QDebug>
#include <QJsonArray>
#include <QJsonDocument>
#include <QCoreApplication>

class configParser        
{
  public:
    explicit configParser()
    {
      qDebug() <<"Create ConfigParser";
      QString applicationPath = QCoreApplication::applicationDirPath();
      QFile file(applicationPath + "/config.json");
      QTextStream textStream(&file);
      QString configString;
      QByteArray text;
      if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) return;
      else {
        configString = QString::fromUtf8(file.readAll());
        QJsonDocument doc = QJsonDocument::fromJson(configString.toUtf8());
        _baseUrl = doc["baseUrl"].toString();
        for(int i = 0;  i < doc["flightSpot"].toArray().size(); ++i){
          _flightSpotList.append(doc["flightSpot"].toArray()[i].toString());
        }
        for(int i = 0;  i < doc["aircraftType"].toArray().size(); ++i){
          _aircraftTypeList.append(doc["aircraftType"].toArray()[i].toString());
        }
        for(int i = 0;  i < doc["batteryCell"].toArray().size(); ++i){
          _batteryCellList.append(QString::number(doc["batteryCell"].toArray()[i].toInt()));
        }
        for(int i = 0;  i < doc["batteryType"].toArray().size(); ++i){
          _batteryTypeList.append(doc["batteryType"].toArray()[i].toString());
        }
        for(int i = 0;  i < doc["position"].toArray().size(); ++i){
          _positionList.append(doc["position"].toArray()[i].toString());
        }
        for(int i = 0;  i < doc["teamName"].toArray().size(); ++i){
          _teamNameList.append(doc["teamName"].toArray()[i].toString());
        }
        for(int i = 0;  i < doc["certification"].toArray().size(); ++i){
          _certificationList.append(doc["certification"].toArray()[i].toString());
        }
        for(int i = 0;  i < doc["payloadType"].toArray().size(); ++i){
          _payloadTypeList.append(doc["payloadType"].toArray()[i].toString());
        }
      }
      file.close();
    };


    QString GetBaseUrl() const { return _baseUrl; }

    QStringList GetFlightSpotList() const {return _flightSpotList; }
    QStringList GetAircraftTypeList() const { return _aircraftTypeList; }
    QStringList GetBatteryCellList() const { return _batteryCellList; }
    QStringList GetBatteryTypeList() const { return _batteryTypeList; }
    QStringList GetPositionList() const { return _positionList; }
    QStringList GetTeamNameList() const { return _teamNameList; }
    QStringList GetCertificationList() const { return _certificationList; }
    QStringList GetPayloadTypeList() const {return _payloadTypeList; }

    static configParser* getInstance(){
      if(gConfigParser == nullptr){
        gConfigParser = new configParser();
        return gConfigParser;
      }
      else return gConfigParser;
    }
private:

  static configParser* gConfigParser;
  QString _baseUrl;
  QJsonDocument _configJsonDoc;
  QStringList _flightSpotList;
  QStringList _aircraftTypeList;
  QStringList _batteryCellList;
  QStringList _batteryTypeList;
  QStringList _positionList;
  QStringList _teamNameList;
  QStringList _certificationList;
  QStringList _payloadTypeList;
};


#endif // CONFIGPARSER_H
