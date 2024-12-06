#include "apiManager.h"

apiManager::apiManager()
  :_apiAccessManager(new QNetworkAccessManager())
{
  qDebug()<<"ApiManager Created";
}

void apiManager::RequestAllData(QString requestUri)
{
  //QNetworkRequest getRequest(_baseUrl.resolved(QUrl(requestUri)));
  QNetworkRequest getRequest(QUrl("http://localhost:8080/aircraft"));
  QNetworkReply *reply = _apiAccessManager->get(getRequest);
  QObject::connect(reply, &QNetworkReply::finished, this, [=]()
  {
    if(reply->error() == QNetworkReply::NoError){
        QByteArray ba=reply->readAll();
        QString contents = QString::fromUtf8(ba);
        qDebug()<<contents;
    }
  });
}
