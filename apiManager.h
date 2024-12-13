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

#ifndef APIMANAGER_H
#define APIMANAGER_H

class apiManager : public QObject
{

Q_OBJECT
Q_DISABLE_COPY(apiManager)

signals:
  void requestFinished();


public:

  explicit apiManager(QObject *parent = nullptr);

  //!NOTE : Aircraft API Request
  QJsonArray* RequestAllAircraftData(QString requestUrl, aircraftModel* dataModel);
  void DeleteAircraftData(QString requestUrl, QString aircraftName);
  void ModifyAircraftData(QString aircraftName, QJsonObject &modifyData);

  //!NOTE : Battery API Request
  void RequestAllBatteryData();
  void DeleteBatteryData();
  void ModifyBatteryData();


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
