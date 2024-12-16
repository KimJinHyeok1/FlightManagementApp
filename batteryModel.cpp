#include "batteryModel.h"

void batteryModel::setBatteryListData(QJsonArray batteryArrayData)
{
  _batteryDataModel->clear();
  for(auto value : batteryArrayData){
      if(value.isObject()){
        _batteryDataModel->append(value.toObject());
      }
  }
  qDebug()<<rowCount();
}

int batteryModel::rowCount(const QModelIndex &parent) const
{
  Q_UNUSED(parent);
  return _batteryDataModel->size();
}

int batteryModel::columnCount(const QModelIndex &parent) const
{
  Q_UNUSED(parent);
  return 4;
}

bool batteryModel::removeRow(int row, const QModelIndex &parent)
{
    if (row < 0 || row >= _batteryDataModel->size())
        return false;

    beginRemoveRows(parent, row, row);
    for (int i = 0; i < 1; ++i) {
        _batteryDataModel->removeAt(row);  // 데이터 삭제
    }
    endRemoveRows();
    return true;
}

QVariant batteryModel::data (const QModelIndex &index, int role) const
{
    int nRow = index.row();
    if(nRow < 0) return QVariant();

    QJsonObject batteryData = _batteryDataModel->at(index.row());
    switch((batteryColumnName)role)
    {
      case batteryColumnName::batterySerialNum :
        return batteryData["batterySerialNum"].toString();
      case batteryColumnName::batteryType :
        return batteryData["batteryType"].toString();
      case batteryColumnName::batteryCapacity :
        return batteryData["batteryCapacity"].toString();
      case batteryColumnName::batteryCell :
        return batteryData["batteryCell"].toString();
       default:
         qDebug() << "Unhandled role:" << role;
         return QVariant();
      }
}

QHash<int, QByteArray> batteryModel::roleNames() const
{
  return _roleName;
}
