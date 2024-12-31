#include "flightdataModel.h"

void flightDataModel::setFlightData(QJsonArray flightData){
  _flightDataModel->clear();
  for(auto value : flightData){
      if(value.isObject()){
        _flightDataModel->append(value.toObject());
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
    //qDebug() << index.row() << "\n";
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
        qDebug() << flightData["flightDataOperator"]
                .toObject()["externalPilot"]
                .toObject()["name"].toString();
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
