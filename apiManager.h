#include <QDebug>
#include <QObject>
#include <QUrl>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QUrlQuery>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>
#include <QStringListModel>

#include "aircraftmodel.h"
#include "batteryModel.h"
#include "operatorModel.h"
#include "flightdataModel.h"
#include "configParser.h"

#ifndef APIMANAGER_H
#define APIMANAGER_H

class apiManager : public QObject
{

Q_OBJECT
Q_DISABLE_COPY(apiManager)

signals:
  void flightDataRequestFinished();
  void aircraftRequestFinished();
  void batteryRequestFinished();
  void operatorRequestFinished();


public:

  explicit apiManager(QObject *parent = nullptr);

  //!NOTE : Aircraft API Request
  void RequestAllAircraftData(QString requestUrl, aircraftModel* dataModel, QStringList &aircraftList);
  bool CreateAircraftData(QJsonObject aircraftData);
  void DeleteAircraftData(QString requestUrl, QString aircraftName);
  void ModifyAircraftData(QString aircraftName, QJsonObject &modifyData);

  //!NOTE : Battery API Request
  void RequestAllBatteryData(QString requestUrl, batteryModel* dataModel, QStringList &batteryList);
  bool CreateBatteryData(QJsonObject batteryData);
  void DeleteBatteryData(QString requestUrl, QString batterySerialNum);
  void ModifyBatteryData(QString batterySerialNum, QJsonObject &modifyData);

  //!NOTE : Operator API Request
  void RequestAllOperatorData(QString requestUrl, operatorModel* dataModel, QStringList &operatorList);
  bool CreateOperatorData(QJsonObject operatorData);
  void DeleteOperatorData(QString requestUrl, int operatorId);
  void ModifyOperatorData(int operatorId, QJsonObject &modifyData);

  //!NOTE : FlightData API Request
  void RequestFlightDataByAircraftName(QString requestUrl, QString aircraftName, flightDataModel* dataModel);
  void RequestFlightDataByDate(QString requestUrl, QDate startDate, QDate endDate, flightDataModel* dataModel);
  void RequestFlightDataByOperatorName(QString requestUrl, QString operatorName, flightDataModel* dataModel);
  void RequestAllFlightData(QString requestUrl, flightDataModel* dataModel);
  bool CreateFlightData(QJsonObject flightData);


  //!NOTE : Api Manager SingleTone Class
  static apiManager* getInstance(){
    if(gApiInstance == nullptr){
      gApiInstance = new apiManager();
      return gApiInstance;
    }
    else return gApiInstance;
  }


private:

  static apiManager* gApiInstance;
  QNetworkAccessManager* _apiAccessManager;
  configParser* _configParser;
  QString _baseUrl;
};

#endif // APIMANAGER_H
