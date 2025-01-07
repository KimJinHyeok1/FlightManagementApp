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
    :_flightDataModel(new QList<QJsonObject>()),
     _flightDate(new QList<QDate>)
    {
      Q_UNUSED(parent)
      _roleName[static_cast<int>(flightDataColumnName::externalPilot)] = "externalPilot";
      _roleName[static_cast<int>(flightDataColumnName::internalPilot)] = "internalPilot";
      _roleName[static_cast<int>(flightDataColumnName::flightNumber)] = "flightNumber";
      _roleName[static_cast<int>(flightDataColumnName::flightDate)] = "flightDate";
      _roleName[static_cast<int>(flightDataColumnName::flightSpot)] = "flightSpot";
      _roleName[static_cast<int>(flightDataColumnName::aircraftName)] = "aircraftName";
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

    //!NOTE : 변경후 바로 반영이 안되는 경우가 있어 Project에서 Header를 다시 import해주면 됨
    enum flightDataColumnName {
      flightNumber = Qt::UserRole,
      externalPilot,
      internalPilot,
      flightDate,
      flightSpot,
      aircraftName,
      battery,
      flightTime,
      payloadItem,
      payloadWeight,
      humidity,
      temperature,
      windSpeed,
      windDirection
    };

    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    virtual int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
    int totalTime(){
      int totalTime = 0;
      for(auto data : *_flightDataModel){
        QTime addTime = QTime::fromString(data["flightTime"].toString(), "hh:mm:ss");
        if(addTime.hour()){
          totalTime += addTime.hour() * 60 + addTime.minute();
        }
        else totalTime += addTime.minute();
      }
      return totalTime;
    }

    int totalDate(){

      QHash<QDate, int> dateCount;
      int uniqueDateCount = 1;
      // 1. 날짜 카운트
      for (const QDate &date : *_flightDate) {
        dateCount[date]++;
      }

      if(dateCount.size() > 1){
        for (auto it = dateCount.begin(); it != dateCount.end(); ++it) {
          if (it.value() == 1) { // 중복되지 않은 날짜
            uniqueDateCount++;
          }
        }
      }
      return uniqueDateCount;
    }

    bool removeRow(int row, const QModelIndex &parent);
    void setOperatorData(QJsonArray operatorData);


protected:
    virtual QHash<int, QByteArray> roleNames() const override;
    QHash<int, QByteArray> _roleName;

private:
  QList<QJsonObject>* _flightDataModel;
  QList<QDate>* _flightDate;

};

#endif // FLIGHTDATAMODEL_H
