#include "dataModel.h"
#include <QObject>
#include <QDebug>


dataModel* dataModel::gInstance = nullptr;
dataModel::dataModel()
  :_apiManager(new apiManager())
{
  qDebug()<<"Data Model Created";
}
dataModel::~dataModel(){}


void
dataModel::aircraftRegisterBtnClicked()
{
  qDebug() << _aircraftName << " " << _aircraftRegisNum << " " <<
              _aircraftType << " " << _aircraftMtow;
}

void
dataModel::getAircraftData()
{
  _apiManager->RequestAllData("test");
}
