#include <QDebug>
#include <QObject>
#include <QUrl>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QJsonObject>
#include <QJsonDocument>

#ifndef APIMANAGER_H
#define APIMANAGER_H

class apiManager : public QObject
{

Q_OBJECT

public:
    apiManager();

  void RequestAllData(QString requestUri);

private:


  QNetworkAccessManager* _apiAccessManager;
};

#endif // APIMANAGER_H
