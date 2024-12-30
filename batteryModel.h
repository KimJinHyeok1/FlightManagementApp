#ifndef BATTERYMODEL_H
#define BATTERYMODEL_H
#include <QAbstractListModel>
#include <QList>
#include <QJsonArray>
#include <QJsonObject>



class batteryModel : public QAbstractListModel
{
    Q_OBJECT
public:

    bool remove(int row){
      return removeRow(row, QModelIndex());
    }

    void setBatteryListData(QJsonArray batteryArrayData);
    explicit batteryModel(QObject* parent = nullptr)
        :_batteryDataModel(new QList<QJsonObject>())
    {
      Q_UNUSED(parent)
      _roleName[(int)batteryColumnName::batterySerialNum] = "batterySerialNum";
      _roleName[(int)batteryColumnName::batteryType] = "batteryType";
      _roleName[(int)batteryColumnName::batteryCapacity] = "batteryCapacity";
      _roleName[(int)batteryColumnName::batteryCell] = "batteryCell";
      _roleName[(int)batteryColumnName::totalUsingTime] = "totalUsingTime";
    }
    // QAbstractItemModel interface

    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    virtual int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
    bool removeRow(int row, const QModelIndex &parent);

    QJsonObject getBatterySpecificData(QString batterySerialNum){
        for(auto value : *_batteryDataModel){
           if(value["batterySerialNum"] == batterySerialNum){
               return value;
           }
        }
    }

    enum class batteryColumnName {
      batterySerialNum = Qt::UserRole,
      batteryType,
      batteryCapacity,
      batteryCell,
      totalUsingTime
    };


protected:
    virtual QHash<int, QByteArray> roleNames() const override;
    QHash<int, QByteArray> _roleName;


private:
    QList<QJsonObject>* _batteryDataModel;
};

#endif // BATTERYMODEL_H
