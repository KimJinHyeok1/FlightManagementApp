#include "datamodel.h"

dataModel::dataModel()
{

}

QStringList dataModel::getAircarftData() const
{
    return _aircarftData;
}

void dataModel::setAircarftData(const QStringList &aircarftData)
{
    _aircarftData = aircarftData;
}
