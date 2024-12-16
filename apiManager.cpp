#include "apiManager.h"

apiManager* apiManager::gApiInstance = nullptr;

apiManager::apiManager(QObject *parent)
  :_apiAccessManager(new QNetworkAccessManager()),
   _baseUrl("http://localhost:8080/")
{
  Q_UNUSED(parent);
  qDebug()<<"ApiManager Created";
}

QJsonArray* apiManager::RequestAllAircraftData(QString requestUrl, aircraftModel* aircraftModel)
{
  QNetworkRequest getRequest(QUrl(_baseUrl).resolved(requestUrl));
  QNetworkReply *reply = _apiAccessManager->get(getRequest);
  QJsonArray* returnData = new QJsonArray();
  QObject::connect(reply, &QNetworkReply::finished, this, [=]()
  {
    if(reply->error() == QNetworkReply::NoError){
        QByteArray ba=reply->readAll();
        QString contents = QString::fromUtf8(ba);
        QJsonObject obj;
        QStringList stringList;
        QJsonDocument response = QJsonDocument::fromJson(contents.toUtf8());
        if(response.isArray()){
           aircraftModel->setAircraftListData(response.array());
           emit requestFinished();
           return response.array();
        };
    }
  });
  return returnData;
}

QJsonArray* apiManager::RequestAllBatteryData(QString requestUrl, batteryModel* batteryModel)
{
  QNetworkRequest getRequest(QUrl(_baseUrl).resolved(requestUrl));
  QNetworkReply *reply = _apiAccessManager->get(getRequest);
  QJsonArray* returnData = new QJsonArray();
  QObject::connect(reply, &QNetworkReply::finished, this, [=]()
  {
    if(reply->error() == QNetworkReply::NoError){
        QByteArray ba=reply->readAll();
        QString contents = QString::fromUtf8(ba);
        QJsonObject obj;
        QStringList stringList;
        QJsonDocument response = QJsonDocument::fromJson(contents.toUtf8());
        if(response.isArray()){
           batteryModel->setBatteryListData(response.array());
           emit requestFinished();
           return response.array();
        };
    }
  });
  return returnData;
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
