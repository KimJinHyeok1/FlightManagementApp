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
  Q_PROPERTY(batteryModel*      battryModel      READ GetBatteryDatas           WRITE SetBatteryData            NOTIFY batteryDatasChanged)

  //Aircraft
  Q_PROPERTY(QString      aircraftName           READ GetAircraftName           WRITE SetAircraftName           NOTIFY aircraftNameChanged)
  Q_PROPERTY(QString      aircraftRegisNum       READ GetAircraftRegisNum       WRITE SetAircraftRegisNum       NOTIFY aircraftRegisNumChanged)
  Q_PROPERTY(QString      aircraftSerialNum      READ GetAircraftSerialNum      WRITE SetAircraftSerialNum      NOTIFY aircraftSerialNumChanged)
  Q_PROPERTY(QString      aircraftType           READ GetAircraftType           WRITE SetAircraftType           NOTIFY aircraftTypeChanged)
  Q_PROPERTY(QString      aircraftMtow           READ GetAircraftMtow           WRITE SetAircraftMtow           NOTIFY aircraftMtowChanged)
  Q_PROPERTY(QString      aircraftDescription    READ GetAircraftDescription    WRITE SetAircraftDescription    NOTIFY aircraftDescriptionChanged)

  //Battery
  Q_PROPERTY(QString      batterySerialNum       READ GetBatterySerialNum       WRITE SetBatterySerialNum       NOTIFY batterySerialNumChanged)
  Q_PROPERTY(QString      batteryType            READ GetBatteryType            WRITE SetBatteryType            NOTIFY batteryTypeChanged)
  Q_PROPERTY(QString      batteryCapacity        READ GetBatteryCapacity        WRITE SetBatteryCapacity        NOTIFY batteryCapacityChanged)
  Q_PROPERTY(QString      batteryCells           READ GetBatteryCells           WRITE SetBatteryCells           NOTIFY batteryCellsChanged)

  Q_PROPERTY(QStringList  aircraftList           READ GetAircraftList           WRITE SetAircraftList           NOTIFY aircraftListChanged)
  Q_PROPERTY(QStringList  batteryList            READ GetBatteryList            WRITE SetBatteryList            NOTIFY batteryListChanged)


  signals:
    void aircraftDatasChanged();
    void batteryDatasChanged();

    void aircraftNameChanged();
    void aircraftRegisNumChanged();
    void aircraftSerialNumChanged();
    void aircraftTypeChanged();
    void aircraftMtowChanged();
    void aircraftDescriptionChanged();
    void aircraftListChanged();

    void batterySerialNumChanged();
    void batteryTypeChanged();
    void batteryCapacityChanged();
    void batteryCellsChanged();
    void batteryListChanged();

public:

    dataModel();
    ~dataModel();

    Q_INVOKABLE void getAircraftData();
    Q_INVOKABLE void getBatteryData();


    Q_INVOKABLE void modifyData(QString dataType);
    Q_INVOKABLE void createData(QString dataType);
    Q_INVOKABLE void deleteData(int row, QString dataType);


    //AircraftData Setter
    void SetAircraftData(aircraftModel* aircraftData){
      _aircraftModel = aircraftData;
      emit aircraftDatasChanged();
    }

    void SetAircraftName(QString aircraftName){
      _aircraftName = aircraftName;
      emit aircraftNameChanged();
    }
    void SetAircraftRegisNum(QString aircraftRegisNum){
      _aircraftRegisNum = aircraftRegisNum;
      emit aircraftRegisNumChanged();
    }
    void SetAircraftSerialNum(QString aircraftSerialNum){
      _aircraftSerialNum = aircraftSerialNum;
      emit aircraftSerialNumChanged();
    }
    void SetAircraftType(QString aircraftType){
      _aircraftType = aircraftType;
      emit aircraftTypeChanged();
    }
    void SetAircraftMtow(QString aircraftMtow){
      _aircraftMtow = aircraftMtow;
      emit aircraftMtowChanged();
    }
    void SetAircraftDescription(QString aircraftDescription){
      _aircraftDescription = aircraftDescription;
      emit aircraftDescriptionChanged();
    }
    void SetAircraftList(QStringList aircraftList){
      _aircraftList = aircraftList;
      emit aircraftListChanged();
    }




    void SetBatterySerialNum(QString batterySerialNum){
      _batterySerialNum = batterySerialNum;
      emit batterySerialNumChanged();
    }
    void SetBatteryType(QString batteryType){
      _batteryType = batteryType;
      emit batteryTypeChanged();
    }
    void SetBatteryCapacity(QString batteryCapacity){
      _batteryCapacity = batteryCapacity;
      emit batteryCapacityChanged();
    }
    void SetBatteryCells(QString batteryCells){
      _batteryCells = batteryCells;
      emit batteryCellsChanged();
    }
    void SetBatteryList(QStringList batteryList){
      _batteryList = batteryList;
      emit batteryListChanged();
    }


   //BatteryData Setter
   void SetBatteryData(batteryModel* batteryModel)
   {
     _batteryModel = batteryModel;
     emit batteryDatasChanged();
   }


    //Getter
    aircraftModel* GetAircraftDatas()    {return _aircraftModel;}
    batteryModel* GetBatteryDatas()      {return _batteryModel;}
    //Aircraft
    QString     GetAircraftName()        {return _aircraftName;}
    QString     GetAircraftRegisNum()    {return _aircraftRegisNum;}
    QString     GetAircraftSerialNum()   {return _aircraftSerialNum;}
    QString     GetAircraftType()        {return _aircraftType;}
    QString     GetAircraftMtow()        {return _aircraftMtow;}
    QString     GetAircraftDescription() {return _aircraftDescription;}
    QStringList GetAircraftList()        {return _aircraftList;}
    //Battery
    QString     GetBatterySerialNum()    {return _batterySerialNum;}
    QString     GetBatteryType()         {return _batteryType;}
    QString     GetBatteryCapacity()     {return _batteryCapacity;}
    QString     GetBatteryCells()        {return _batteryCells;}
    QStringList GetBatteryList()         {return _batteryList;}

private:
    static dataModel* gInstance;

    //Aircraft Data
    QString _aircraftName;
    QString _aircraftRegisNum;
    QString _aircraftSerialNum;
    QString _aircraftType;
    QString _aircraftMtow;
    QString _aircraftDescription;
    aircraftModel* _aircraftModel;

    //Battery Data
    QString _batterySerialNum;
    QString _batteryType;
    QString _batteryCapacity;
    QString _batteryCells;
    batteryModel* _batteryModel;

    //FlightData
    QStringList _aircraftList;
    QStringList _batteryList;

    apiManager *_apiManager;
};
