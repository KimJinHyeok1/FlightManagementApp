#include "apiManager.h"

apiManager* apiManager::gApiInstance = nullptr;

apiManager::apiManager(QObject *parent)
  :_apiAccessManager(new QNetworkAccessManager()),
   _baseUrl("http://localhost:8080/")
{
  Q_UNUSED(parent);
  qDebug()<<"ApiManager Created";
}

void apiManager::RequestAllAircraftData(QString requestUrl,
                                               aircraftModel* aircraftModel,
                                               QStringList &aircraftList)
{
  QNetworkRequest getRequest(QUrl(_baseUrl).resolved(requestUrl));
  QNetworkReply *reply = _apiAccessManager->get(getRequest);
  QObject::connect(reply, &QNetworkReply::finished, this, [=, &aircraftList]()
  {
    if(reply->error() == QNetworkReply::NoError){
        QByteArray ba=reply->readAll();
        QString contents = QString::fromUtf8(ba);
        QJsonDocument response = QJsonDocument::fromJson(contents.toUtf8());
        if(response.isArray()){
           for(auto value : response.array()){
             aircraftList.append(value.toObject()["aircraftName"].toString());
           }
           aircraftModel->setAircraftListData(response.array());
           emit aircraftRequestFinished();
        };
      }
  });

}

bool apiManager::CreateAircraftData(QJsonObject aircraftData)
{
    QNetworkRequest postRequest(QUrl(_baseUrl).resolved(QString("/aircraft")));
    postRequest.setHeader(QNetworkRequest::ContentTypeHeader, QString("application/json; charset=utf-8"));
    QJsonDocument jsonDoc(aircraftData);
    QByteArray jsonData = jsonDoc.toJson(QJsonDocument::Compact);
    QNetworkReply *reply = _apiAccessManager->post(postRequest, jsonData);
    QObject::connect(reply, &QNetworkReply::finished, this, [=]()
    {
      if(reply->error() == QNetworkReply::NoError){
          QByteArray ba=reply->readAll();
          QString contents = QString::fromUtf8(ba);
          QJsonObject obj;
          QStringList stringList;
          QJsonDocument response = QJsonDocument::fromJson(contents.toUtf8());
          if(response.isArray()){
             return true;
          };
      }

    });return false;
}
void apiManager::RequestAllBatteryData(QString requestUrl, batteryModel* batteryModel, QStringList &batteryList)
{
  QNetworkRequest getRequest(QUrl(_baseUrl).resolved(requestUrl));
  QNetworkReply *reply = _apiAccessManager->get(getRequest);
  QObject::connect(reply, &QNetworkReply::finished, this, [=, &batteryList]()
  {
    if(reply->error() == QNetworkReply::NoError){
        QByteArray ba=reply->readAll();
        QString contents = QString::fromUtf8(ba);
        QJsonDocument response = QJsonDocument::fromJson(contents.toUtf8());
        if(response.isArray()){
           for(const auto value : response.array()){
             batteryList.append(value.toObject()["batterySerialNum"].toString());
           }
           batteryModel->setBatteryListData(response.array());
           emit batteryRequestFinished();
        };
    }
  });
}

bool apiManager::CreateBatteryData(QJsonObject batteryData)
{
    QNetworkRequest postRequest(QUrl(_baseUrl).resolved(QString("/battery")));
    postRequest.setHeader(QNetworkRequest::ContentTypeHeader, QString("application/json; charset=utf-8"));
    QJsonDocument jsonDoc(batteryData);
    QByteArray jsonData = jsonDoc.toJson(QJsonDocument::Compact);
    QNetworkReply *reply = _apiAccessManager->post(postRequest, jsonData);
    QObject::connect(reply, &QNetworkReply::finished, this, [=]()
    {
      if(reply->error() == QNetworkReply::NoError){
          QByteArray ba=reply->readAll();
          QString contents = QString::fromUtf8(ba);
          QJsonObject obj;
          QStringList stringList;
          QJsonDocument response = QJsonDocument::fromJson(contents.toUtf8());
          if(response.isArray()){
             return true;
          };
      }
    });return false;
}



void apiManager::ModifyAircraftData(QString aircraftName, QJsonObject &modifyData)
{
  QUrl url = QUrl(_baseUrl).resolved("aircraft/" + aircraftName);
  QNetworkRequest modifyRequest(url);
  modifyRequest.setHeader(QNetworkRequest::ContentTypeHeader, QString("application/json; charset=utf-8"));
  QJsonDocument jsonDoc(modifyData);
  QByteArray jsonData = jsonDoc.toJson(QJsonDocument::Compact);
  QNetworkReply *reply = _apiAccessManager->sendCustomRequest(modifyRequest, "PATCH", jsonData);
  QObject::connect(reply, &QNetworkReply::finished, this, [=](){
      if(reply->error() == QNetworkReply::NoError)
        qDebug()<< "Data Modified";
  });
}


void apiManager::ModifyBatteryData(QString batterySerialNum, QJsonObject &modifyData)
{
  QUrl url = QUrl(_baseUrl).resolved("battery/" + batterySerialNum);
  QNetworkRequest modifyRequest(url);
  modifyRequest.setHeader(QNetworkRequest::ContentTypeHeader, QString("application/json; charset=utf-8"));
  QJsonDocument jsonDoc(modifyData);
  QByteArray jsonData = jsonDoc.toJson(QJsonDocument::Compact);
  QNetworkReply *reply = _apiAccessManager->sendCustomRequest(modifyRequest, "PATCH", jsonData);
  QObject::connect(reply, &QNetworkReply::finished, this, [=](){
      if(reply->error() == QNetworkReply::NoError)
        qDebug()<< "Data Modified";
  });
}



void apiManager::DeleteAircraftData(QString requestUrl, QString aircraftName)
{
  QUrlQuery query;
  query.addQueryItem("aircraftName", aircraftName);
  QUrl url = QUrl(_baseUrl).resolved(requestUrl);
  url.setQuery(query);
  QNetworkRequest deleteRequest(url);
  QNetworkReply *reply = _apiAccessManager->deleteResource(deleteRequest);
  QObject::connect(reply, &QNetworkReply::finished, this, [=](){
    if(reply->error() == QNetworkReply::NoError)
        qDebug()<< "deleted";
  });
}

void apiManager::DeleteBatteryData(QString requestUrl, QString batterySerialNum)
{
  QUrlQuery query;
  qDebug()<< batterySerialNum;
  query.addQueryItem("batterySerialNum", batterySerialNum);
  QUrl url = QUrl(_baseUrl).resolved(requestUrl);
  url.setQuery(query);
  QNetworkRequest deleteRequest(url);
  QNetworkReply *reply = _apiAccessManager->deleteResource(deleteRequest);
  QObject::connect(reply, &QNetworkReply::finished, this, [=](){
    if(reply->error() == QNetworkReply::NoError)
        qDebug()<< "deleted";
  });
}
