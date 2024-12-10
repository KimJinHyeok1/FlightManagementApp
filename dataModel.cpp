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
  _apiManager->RequestAllAircraftData("/aircraft", _aircraftModel);
}

void
dataModel::updateAircraftData()
{
  qDebug()<<_aircraftModel->rowCount();
}


void dataModel::deleteData(){
  _aircraftModel->deleteData();
  emit aircraftDatasChanged();
  //_apiManager->DeleteAircraftData("/aircraft", _aircraftName);
}
