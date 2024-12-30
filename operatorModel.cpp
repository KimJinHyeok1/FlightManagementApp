#include "operatorModel.h"

void operatorModel::setOperatorData(QJsonArray operatorData)
{
  _operatorModel->clear();
  for(auto value : operatorData){
      if(value.isObject()){
        _operatorModel->append(value.toObject());
      }
  }
}

int operatorModel::rowCount(const QModelIndex &parent) const
{
  Q_UNUSED(parent);
  return _operatorModel->size();
}

int operatorModel::columnCount(const QModelIndex &parent) const
{
  Q_UNUSED(parent);
  return 6;
}

bool operatorModel::removeRow(int row, const QModelIndex &parent)
{
    if (row < 0 || row >= _operatorModel->size())
        return false;

    beginRemoveRows(parent, row, row);
    for (int i = 0; i < 1; ++i) {
        _operatorModel->removeAt(row);  // 데이터 삭제
    }
    endRemoveRows();
    return true;
}

QVariant operatorModel::data (const QModelIndex &index, int role) const
{
    int nRow = index.row();
    if(nRow < 0) return QVariant();
    QJsonObject operatorData = _operatorModel->at(index.row());
    switch(static_cast<operatorColumnName>(role))
    {
      case operatorColumnName::id :
        return operatorData["id"].toInt();
      case operatorColumnName::name :
        return operatorData["name"].toString();
      case operatorColumnName::phoneNumber :
        return operatorData["phoneNumber"].toString();
      case operatorColumnName::position :
        return operatorData["position"].toString();
      case operatorColumnName::teamName :
        return operatorData["teamName"].toString();
      case operatorColumnName::certification :
        return operatorData["certification"].toString();
      default:
        qDebug() << "Unhandled role:" << role;
       return QVariant();
      }
}

QHash<int, QByteArray> operatorModel::roleNames() const
{
  return _roleName;
}
