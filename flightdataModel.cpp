#include "flightdataModel.h"

void flightDataModel::setFlightData(QJsonArray flightData){
  _flightDataModel->clear();
  _flightDate->clear();
  for(auto value : flightData){
      if(value.isObject()){
        qDebug() << value.toObject();
        _flightDataModel->append(value.toObject());
        _flightDate->append(QDate::fromString(value.toObject()["flightDate"].toString(),
                           "yyyy-MM-dd"));
      }
  }
}

int flightDataModel::rowCount(const QModelIndex &parent) const
{
  Q_UNUSED(parent);
  return _flightDataModel->size();
}

int flightDataModel::columnCount(const QModelIndex &parent) const
{
  Q_UNUSED(parent);
  return 14;
}

QVariant flightDataModel::data(const QModelIndex &index, int role) const
{
    int nRow = index.row();
    if(nRow < 0) return QVariant();

    QJsonObject flightData = _flightDataModel->at(index.row());
    switch((flightDataColumnName)role)
    {
       case flightDataColumnName::flightNumber :
        return flightData["flightNumber"].toString();
       case flightDataColumnName::flightDate :
        return flightData["flightDate"].toString();
       case flightDataColumnName::aircraftName :
        return flightData["aircraft"].toObject()["aircraftName"].toString();
       case flightDataColumnName::battery :
        return flightData["battery"].toString();
       case flightDataColumnName::flightTime :
        return flightData["flightTime"].toString();
       case flightDataColumnName::flightSpot :
        return flightData["flightSpot"].toString();
       case flightDataColumnName::payloadItem :
        return flightData["payloadItem"].toString();
       case flightDataColumnName::payloadWeight :
        return flightData["payloadWeight"].toInt();
       case flightDataColumnName::humidity :
        return flightData["humidity"].toInt();
       case flightDataColumnName::temperature :
        return flightData["temperature"].toInt();
       case flightDataColumnName::windSpeed :
        return flightData["windSpeed"].toInt();
       case flightDataColumnName::windDirection :
        return flightData["windDirection"].toInt();
       case flightDataColumnName::externalPilot :
        return flightData["flightDataOperator"]
          .toObject()["externalPilot"]
          .toObject()["name"].toString();
       case flightDataColumnName::internalPilot :
        return flightData["flightDataOperator"]
         .toObject()["internalPilot"]
         .toObject()["name"].toString();
       default:
         qDebug() << "Unhandled role:" << role;
         return QVariant();
    }
}

QHash<int, QByteArray> flightDataModel::roleNames() const
{
  return _roleName;
}
