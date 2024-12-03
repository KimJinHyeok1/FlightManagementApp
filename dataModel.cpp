#include "dataModel.h"
#include <QObject>
#include <QDebug>


dataModel::dataModel()
{}

dataModel::~dataModel()
{}


void
dataModel::aircraftRegisterBtnClicked()
{
  qDebug() << _aircraftName << " " << _aircraftRegisNum << " " <<
              _aircraftType << " " << _aircraftMtow;
}
