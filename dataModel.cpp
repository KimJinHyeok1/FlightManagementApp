#include "dataModel.h"
#include <QObject>
#include <QDebug>


dataModel* dataModel::gInstance = nullptr;
dataModel::dataModel()
  :_aircraftModel(new aircraftModel()),
  _batteryDatas(new QStringListModel(this))
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


void dataModel::modifyAircraftData(){

  QJsonObject modifyData;
  modifyData["aircraftRegisterNum"] = _aircraftRegisNum;
  modifyData["aircraftSerialNum"] = _aircraftSerialNum;
  modifyData["aircraftType"] =_aircraftType;
  modifyData["aircraftMtow"] = _aircraftMtow;
  modifyData["aircraftDescription"] = _aircraftDescription;

  qDebug()<<modifyData["aircraftDescription"];
  qDebug()<<modifyData["aircraftType"];

  _apiManager->ModifyAircraftData(_aircraftName, modifyData);

}


void dataModel::deleteAircraftData(int row){
  _apiManager->DeleteAircraftData("/aircraft", _aircraftName);
  _aircraftModel->remove(row);
  emit aircraftDatasChanged();
}
