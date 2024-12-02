#ifndef DATAMODEL_H
#define DATAMODEL_H
#include <QObject>
#include <QDebug>

#endif // DATAMODEL_H

class dataModel : public QObject
{
  Q_OBJECT
  Q_PROPERTY(QStringList  aircraftDatas          READ GetAircraftDatas          WRITE SetAircraftDatas          NOTIFY aircraftDatasChanged)
  Q_PROPERTY(QStringList  battryDatas            READ GetBatteryDatas           WRITE SetBatteryDatas           NOTIFY battryDatasChanged)

  Q_PROPERTY(QString      aircraftName           READ GetAircraftName           WRITE SetAircraftName           NOTIFY aircraftNameChanged)
  Q_PROPERTY(QString      aircraftRegisNum       READ GetAircraftRegisNum       WRITE SetAircraftRegisNum       NOTIFY aircraftRegisNumChanged)
  Q_PROPERTY(QString      aircraftType           READ GetAircraftType           WRITE SetAircraftType           NOTIFY aircraftTypeChanged)
  Q_PROPERTY(QString      aircraftMtow           READ GetAircraftMtow           WRITE SetAircraftMtow           NOTIFY aircraftMtowChanged)


  signals:
    void aircraftDatasChanged();
    void battryDatasChanged();

    void aircraftNameChanged();
    void aircraftRegisNumChanged();
    void aircraftTypeChanged();
    void aircraftMtowChanged();

public:
    dataModel();
    ~dataModel();

    //Setter
    void SetAircraftDatas(QStringList aircraftDatas){_aircraftDatas = aircraftDatas;}
    void SetBatteryDatas(QStringList battryDatas){_batteryDatas= battryDatas;}

    void SetAircraftName(QString aircraftName){
        _aircraftName = aircraftName;
        qDebug() << _aircraftName;
        emit aircraftNameChanged();
    }
    void SetAircraftRegisNum(QString aircraftRegisNum){
        _aircraftRegisNum = aircraftRegisNum;
        qDebug() << _aircraftRegisNum;
        emit aircraftRegisNumChanged();
    }
    void SetAircraftType(QString aircraftType){
        _aircraftType = aircraftType;
        qDebug() << _aircraftType;
        emit aircraftTypeChanged();
    }
    void SetAircraftMtow(QString aircraftMtow){
        _aircraftMtow = aircraftMtow;
        qDebug() << _aircraftMtow;
        emit aircraftMtowChanged();
    }


    //Getter
    QStringList GetAircraftDatas(){return _aircraftDatas;}
    QStringList GetBatteryDatas() {return _aircraftDatas;}

    QString     GetAircraftName() {return _aircraftName;}
    QString     GetAircraftRegisNum(){return _aircraftRegisNum;}
    QString     GetAircraftType() {return _aircraftType;}
    QString     GetAircraftMtow() {return _aircraftMtow;}

private:

    QStringList _aircraftDatas;
    QStringList _batteryDatas;

    QString _aircraftName;
    QString _aircraftRegisNum;
    QString _aircraftType;
    QString _aircraftMtow;

};
