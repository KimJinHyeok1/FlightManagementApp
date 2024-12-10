#ifndef DATAMODEL_H
#define DATAMODEL_H

#include <QDebug>
#include <QStringListModel>
#include "apiManager.h"
#endif // DATAMODEL_H

class dataModel : public QObject
{
  Q_OBJECT

  Q_PROPERTY(aircraftModel*     aircraftModel    READ GetAircraftDatas          WRITE SetAircraftData           NOTIFY aircraftDatasChanged)
  Q_PROPERTY(QStringListModel*  battryDatas      READ GetBatteryDatas                                           NOTIFY battryDatasChanged)

  Q_PROPERTY(QString      aircraftName           READ GetAircraftName           WRITE SetAircraftName           NOTIFY aircraftNameChanged)
  Q_PROPERTY(QString      aircraftRegisNum       READ GetAircraftRegisNum       WRITE SetAircraftRegisNum       NOTIFY aircraftRegisNumChanged)
  Q_PROPERTY(QString      aircraftSerialNum      READ GetAircraftSerialNum      WRITE SetAircraftSerialNum      NOTIFY aircraftSerialNumChanged)
  Q_PROPERTY(QString      aircraftType           READ GetAircraftType           WRITE SetAircraftType           NOTIFY aircraftTypeChanged)
  Q_PROPERTY(QString      aircraftMtow           READ GetAircraftMtow           WRITE SetAircraftMtow           NOTIFY aircraftMtowChanged)
  Q_PROPERTY(QString      aircraftDescription    READ GetAircraftDescription   WRITE SetAircraftDescription     NOTIFY aircraftDescriptionChanged)


  signals:

    void aircraftDatasChanged();
    void battryDatasChanged();

    void aircraftNameChanged();
    void aircraftRegisNumChanged();
    void aircraftSerialNumChanged();
    void aircraftTypeChanged();
    void aircraftMtowChanged();
    void aircraftDescriptionChanged();


public:

    dataModel();
    ~dataModel();

    Q_INVOKABLE void getAircraftData();
    Q_INVOKABLE void deleteData();
    Q_INVOKABLE void updateAircraftData();


    //AircraftData Setter

    void SetAircraftData(aircraftModel* aircraftData){
      _aircraftModel = aircraftData;
      qDebug() << "Set AircraftData";
      emit aircraftDatasChanged();
    }

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
    void SetAircraftSerialNum(QString aircraftSerialNum){
      _aircraftSerialNum = aircraftSerialNum;
      qDebug() << _aircraftSerialNum;
      emit aircraftSerialNumChanged();
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
    void SetAircraftDescription(QString aircraftDescription){
      _aircraftDescription = aircraftDescription;
      qDebug() << _aircraftDescription;
      emit aircraftDescriptionChanged();
    }



   //BatteryData Setter
   void SetBatteryDatas(){}


    //Getter
    aircraftModel* GetAircraftDatas() {
        qDebug() << "Get AircraftData";
        return _aircraftModel;
    }
    QStringListModel* GetBatteryDatas() {return _batteryDatas;}

    QString     GetAircraftName() {return _aircraftName;}
    QString     GetAircraftRegisNum(){return _aircraftRegisNum;}
    QString     GetAircraftSerialNum(){return _aircraftSerialNum;}
    QString     GetAircraftType() {return _aircraftType;}
    QString     GetAircraftMtow() {return _aircraftMtow;}
    QString     GetAircraftDescription() {return _aircraftDescription;}

private:
    static dataModel* gInstance;

    aircraftModel* _aircraftModel;
    QJsonArray _aircraftDataModels;
    QStringListModel* _batteryDatas;

    QString _aircraftName;
    QString _aircraftRegisNum;
    QString _aircraftSerialNum;
    QString _aircraftType;
    QString _aircraftMtow;
    QString _aircraftDescription;

    apiManager *_apiManager;
};
