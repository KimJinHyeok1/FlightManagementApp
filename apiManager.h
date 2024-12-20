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

#ifndef APIMANAGER_H
#define APIMANAGER_H

class apiManager : public QObject
{

Q_OBJECT
Q_DISABLE_COPY(apiManager)

signals:
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
  QString _baseUrl;
};

#endif // APIMANAGER_H
