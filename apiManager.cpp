#include "apiManager.h"

apiManager* apiManager::gApiInstance = nullptr;

apiManager::apiManager(QObject *parent)
  :_apiAccessManager(new QNetworkAccessManager()),
   _baseUrl("http://localhost:8080")
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
           qDebug()<<"data Set";
           aircraftModel->setAircraftListData(response.array());
           emit requestFinished();
           return response.array();
        };
    }
  });
  return returnData;
}


void apiManager::DeleteAircraftData(QString requestUrl, QString aircraftName)
{
  QUrlQuery query;
  qDebug()<< aircraftName;
  query.addQueryItem("aircraftName", aircraftName);
  QUrl url = QUrl(_baseUrl).resolved(requestUrl);
  url.setQuery(query);
  qDebug()<< url;
  QNetworkRequest deleteRequest(url);
  QNetworkReply *reply = _apiAccessManager->deleteResource(deleteRequest);
  QObject::connect(reply, &QNetworkReply::finished, this, [=](){
    if(reply->error() == QNetworkReply::NoError)
        qDebug()<< "deleted";
  });
}
