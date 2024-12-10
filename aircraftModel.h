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

    void deleteData();

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
