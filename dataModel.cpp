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
  _apiManager->RequestAllAircraftData("aircraft", _aircraftModel);
}

void
dataModel::getBatteryData()
{
  _apiManager->RequestAllBatteryData("battery", _batteryModel);
}


void dataModel::modifyAircraftData(){
  QJsonObject modifyData;
  modifyData["aircraftRegisterNum"] = _aircraftRegisNum;
  modifyData["aircraftSerialNum"] = _aircraftSerialNum;
  modifyData["aircraftType"] =_aircraftType;
  modifyData["aircraftMtow"] = _aircraftMtow;
  modifyData["aircraftDescription"] = _aircraftDescription;
  _apiManager->ModifyAircraftData(_aircraftName, modifyData);
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
