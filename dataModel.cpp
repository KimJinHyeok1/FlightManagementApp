#include "dataModel.h"
#include <QObject>
#include <QDebug>


dataModel* dataModel::gInstance = nullptr;
dataModel::dataModel()
  :_aircraftModel(new aircraftModel()),
  _batteryModel(new batteryModel())
{
  _apiManager = apiManager::getInstance();
  qDebug()<<"Aircarft Data Model Created";
}
dataModel::~dataModel(){}


void
dataModel::getAircraftData()
{
  _apiManager->RequestAllAircraftData("aircraft", _aircraftModel, _aircraftList);
  qDebug()<<_aircraftList;
}

void
dataModel::getBatteryData()
{
  _apiManager->RequestAllBatteryData("battery", _batteryModel, _batteryList);
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

}
