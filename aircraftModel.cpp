#include "aircraftmodel.h"


void aircraftModel::setAircraftListData(QJsonArray aircraftArrayData){
  _aircraftDataModel->clear();
  for(auto value : aircraftArrayData){
      if(value.isObject()){
        _aircraftDataModel->append(value.toObject());
      }
  }
  qDebug()<<rowCount();
}

int aircraftModel::columnCount(const QModelIndex &parent) const{
  Q_UNUSED(parent)
  return 6;
}

int aircraftModel::rowCount(const QModelIndex &parent) const
{
  //!NOTE: Listview를 표출하기 위한 index 값 반환함수
  Q_UNUSED(parent);
  return _aircraftDataModel->size();
}

void aircraftModel::deleteData(){
  _aircraftDataModel->removeFirst();
  qDebug()<<rowCount();
}

QVariant aircraftModel::data (const QModelIndex &index, int role) const
{
  int nRow = index.row();
  if(nRow < 0) return QVariant();

  QJsonObject aircraftData = _aircraftDataModel->at(index.row());
  switch((aircraftColumnName)role)
  {
    case aircraftColumnName::aircraftName :
      return aircraftData["aircraftName"].toString();
    case aircraftColumnName::aircraftSerialNum :
      return aircraftData["aircraftSerialNum"].toString();
    case aircraftColumnName::aircraftRegisterNum :
      return aircraftData["aircraftRegisterNum"].toString();
    case aircraftColumnName::aircraftType :
      return aircraftData["aircraftType"].toString();
    case aircraftColumnName::aircraftMTOW :
      return QString::number(aircraftData["aircraftMTOW"].toDouble()) + "Kg";
    case aircraftColumnName::aircraftDescription :
      return aircraftData["aircraftDescription"].toString();
     default:
       qDebug() << "Unhandled role:" << role; // 디버깅 출력
       return QVariant();
    }
}

QHash<int, QByteArray> aircraftModel::roleNames() const
{
  return _roleName;
}
