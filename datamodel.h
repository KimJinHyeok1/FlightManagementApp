#ifndef DATAMODEL_H
#define DATAMODEL_H
#include <QObject>

class dataModel : public QObject
{
  Q_OBJECT
  Q_PROPERTY (QStringList aircraftData READ getAircarftData WRITE setAircarftData);

  signals:

public:
  dataModel();

  //Getter
  QStringList getAircarftData() const;

  //Setter
  void setAircarftData(const QStringList &aircarftData);



private:
  QStringList _aircarftData;
};

#endif // DATAMODEL_H
