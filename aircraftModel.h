#ifndef AIRCRAFTMODEL_H
#define AIRCRAFTMODEL_H
#include <QAbstractListModel>
#include <QList>
#include <QJsonArray>
#include <QJsonObject>



class aircraftModel : public QAbstractListModel
{


Q_OBJECT

public:

    bool remove(int row){
      return removeRow(row, QModelIndex());
    }

    void setAircraftListData(QJsonArray data);
    explicit aircraftModel(QObject* parent = nullptr)
        :_aircraftDataModel(new QList<QJsonObject>())
    {
      Q_UNUSED(parent)
      _roleName[(int)aircraftColumnName::aircraftName] = "aircraftName";
      _roleName[(int)aircraftColumnName::aircraftSerialNum] = "aircraftSerialNum";
      _roleName[(int)aircraftColumnName::aircraftRegisterNum] = "aircraftRegisterNum";
      _roleName[(int)aircraftColumnName::aircraftType] = "aircraftType";
      _roleName[(int)aircraftColumnName::aircraftMTOW] = "aircraftMTOW";
      _roleName[(int)aircraftColumnName::aircraftDescription] = "aircraftDescription";
    };

    ~aircraftModel(){}

    bool removeRow(int row, const QModelIndex &parent) {
        if (row < 0 || row >= _aircraftDataModel->size())
            return false;

        beginRemoveRows(parent, row, row);
        for (int i = 0; i < 1; ++i) {
            _aircraftDataModel->removeAt(row);  // 데이터 삭제
        }
        endRemoveRows();
        return true;
    }

    virtual int rowCount(const QModelIndex& parent = QModelIndex()) const override;
    virtual int columnCount(const QModelIndex& parent = QModelIndex()) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;

    enum class aircraftColumnName {
      aircraftName = Qt::UserRole,
      aircraftSerialNum,
      aircraftRegisterNum,
      aircraftType,
      aircraftMTOW,
      aircraftDescription = 262
    };

protected:
    virtual QHash<int, QByteArray> roleNames() const override;
    QHash<int, QByteArray> _roleName;

private:
  QList<QJsonObject>* _aircraftDataModel;

};

#endif // AIRCRAFTMODEL_H
