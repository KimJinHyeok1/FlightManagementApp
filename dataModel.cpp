#include "dataModel.h"
#include <QObject>
#include <QDebug>


dataModel* dataModel::gInstance = nullptr;
dataModel::dataModel()
  :_aircraftModel(new aircraftModel()),
  _batteryModel(new batteryModel()),
  _flightDataModel(new flightDataModel()),
  _operatorModel(new operatorModel())
{
  _startTime = QTime(0, 0, 0);
  _apiManager = apiManager::getInstance();
  qDebug()<<"Aircarft Data Model Created";
}
dataModel::~dataModel(){}


void
dataModel::getAircraftData()
{
  _apiManager->RequestAllAircraftData("aircraft", _aircraftModel, _aircraftList);
}

void
dataModel::getBatteryData()
{
  _apiManager->RequestAllBatteryData("battery", _batteryModel, _batteryList);
}

void
dataModel::getOperatorData()
{
  _apiManager->RequestAllOperatorData("operator", _operatorModel, _operatorList);
}
void
dataModel::getFlightData()
{
  _apiManager->RequestAllFlightData("flightData/all", _flightDataModel);
}



void dataModel::createData(QString dataType){
  QJsonObject DataObject;

  if(dataType == "aircraft"){
    DataObject["aircraftName"] = _aircraftName;
    DataObject["aircraftRegisterNum"] = _aircraftRegisNum;
    DataObject["aircraftSerialNum"] = _aircraftSerialNum;
    DataObject["aircraftType"] =_aircraftType;
    DataObject["aircraftMtow"] = _aircraftMtow;
    DataObject["aircraftDescription"] = _aircraftDescription;
    _apiManager->CreateAircraftData(DataObject);
  }

  else if(dataType == "battery"){
    DataObject["batterySerialNum"] = _batterySerialNum;
    DataObject["batteryType"] = _batteryType;
    DataObject["batteryCapacity"] = _batteryCapacity;
    DataObject["batteryCell"] = _batteryCells;
    _apiManager->CreateBatteryData(DataObject);
  }

  else if(dataType == "operator"){
    DataObject["name"] = _operatorName;
    DataObject["phoneNumber"] = _phoneNumber;
    DataObject["teamName"] = _teamName;
    DataObject["position"] = _position;
    DataObject["certification"] = _certification;
    _apiManager->CreateOperatorData(DataObject);
  }

  else if(dataType == "flightData"){
    DataObject["flightNumber"] = "FL" + _flightDate.toString("yyMMdd") + _startTime.toString("HHmm");
    DataObject["aircraftName"] = _aircraftName;

    QJsonArray batteryArray = QJsonArray::fromStringList(_flightBatteryList);
    DataObject["flightBatteries"] = batteryArray;

    QJsonArray operatorArray = QJsonArray();
    operatorArray.append(_externalPilot);
    operatorArray.append(_internalPilot);

    DataObject["operators"] = operatorArray;
    DataObject["humidity"] = _humidity;
    DataObject["payloadWeight"] = _payloadWeight;
    DataObject["windSpeed"] = _windSpeed;
    DataObject["windDirection"] = _windDirection;
    DataObject["temperature"] = _temperature;
    DataObject["flightDate"] = _flightDate.toString("yyyy-MM-dd");
    DataObject["flightTime"] = _flightTime.toString("HH:mm");
    DataObject["payloadType"] = _payloadType;
    DataObject["payloadWeight "] = _payloadWeight;

    _apiManager->CreateFlightData(DataObject);
  }
}


void dataModel::modifyData(QString dataType){
  QJsonObject DataObject;

  if(dataType == "aircraft"){
    DataObject["aircraftRegisterNum"] = _aircraftRegisNum;
    DataObject["aircraftSerialNum"] = _aircraftSerialNum;
    DataObject["aircraftType"] =_aircraftType;
    DataObject["aircraftMtow"] = _aircraftMtow;
    DataObject["aircraftDescription"] = _aircraftDescription;
    _apiManager->ModifyAircraftData(_aircraftName, DataObject);
  }

  else if(dataType == "battery"){
    DataObject["batteryType"] = _batteryType;
    DataObject["batteryCapacity"] = _batteryCapacity;
    DataObject["batteryCell"] = _batteryCells;
    _apiManager->ModifyBatteryData(_batterySerialNum, DataObject);
  }

//  else if(dataType == "operator"){
//    DataObject["name"] = _operatorName;
//    DataObject["phoneNumber"] = _phoneNumber;
//    DataObject["teamName"] = _teamName;
//    DataObject["position"] = _position;
//    DataObject["certification"] = _certification;
//    _apiManager->CreateOperatorData(DataObject);
//  }
}


void dataModel::deleteData(int row, QString dataType){
  if(dataType == "aircraft"){
    _apiManager->DeleteAircraftData("/aircraft", _aircraftName);
    _aircraftModel->remove(row);
    emit aircraftDatasChanged();
  }

  else if(dataType == "battery"){
    _apiManager->DeleteBatteryData("/battery", _batterySerialNum);
    _batteryModel->remove(row);
    emit batteryDatasChanged();
  }

  else if(dataType == "operator"){
    _apiManager->DeleteOperatorData("/operator", _operatorId);
    _operatorModel->remove(row);
    emit batteryDatasChanged();
  }
}
