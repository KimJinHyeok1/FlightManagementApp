#ifndef FLIGHTDATAMODEL_H
#define FLIGHTDATAMODEL_H
#include <QAbstractListModel>
#include <QList>
#include <QJsonArray>
#include <QJsonObject>

class flightDataModel  : public QAbstractListModel
{

Q_OBJECT

public:

    void setFlightData(QJsonArray flightData);

    explicit flightDataModel(QObject* parent = nullptr)
    :_flightDataModel(new QList<QJsonObject>())
    {
      Q_UNUSED(parent)
      _roleName[static_cast<int>(flightDataColumnName::flightNumber)] = "flightNumber";
      _roleName[static_cast<int>(flightDataColumnName::flightDate)] = "flightDate";
      _roleName[static_cast<int>(flightDataColumnName::aircraft)] = "aircraft";
      _roleName[static_cast<int>(flightDataColumnName::battery)] = "battery";
      _roleName[static_cast<int>(flightDataColumnName::flightTime)] = "flightTime";
      _roleName[static_cast<int>(flightDataColumnName::payloadItem)] = "payloadItem";
      _roleName[static_cast<int>(flightDataColumnName::payloadWeight)] = "payloadWeight";
      _roleName[static_cast<int>(flightDataColumnName::humidity)] = "humidity";
      _roleName[static_cast<int>(flightDataColumnName::temperature)] = "temperature";
      _roleName[static_cast<int>(flightDataColumnName::windSpeed)] = "windSpeed";
      _roleName[static_cast<int>(flightDataColumnName::windDirection)] = "windDirection";

    }
    ~flightDataModel(){};

    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    virtual int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
    bool removeRow(int row, const QModelIndex &parent);
    void setOperatorData(QJsonArray operatorData);


    enum flightDataColumnName {
      flightNumber = Qt::UserRole,
      flightDate,
      aircraft,
      battery,
      flightTime,
      payloadItem,
      payloadWeight,
      humidity,
      temperature,
      windSpeed,
      windDirection
    };


protected:
    virtual QHash<int, QByteArray> roleNames() const override;
    QHash<int, QByteArray> _roleName;

private:
  QList<QJsonObject>* _flightDataModel;
};

#endif // FLIGHTDATAMODEL_H
