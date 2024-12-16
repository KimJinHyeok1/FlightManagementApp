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
    }
    // QAbstractItemModel interface

    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    virtual int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
    bool removeRow(int row, const QModelIndex &parent);

    enum class batteryColumnName {
      batterySerialNum = Qt::UserRole,
      batteryType,
      batteryCapacity,
      batteryCell
    };

protected:
    virtual QHash<int, QByteArray> roleNames() const override;
    QHash<int, QByteArray> _roleName;


private:
    QList<QJsonObject>* _batteryDataModel;
};

#endif // BATTERYMODEL_H
