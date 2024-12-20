#ifndef OPERATORMODEL_H
#define OPERATORMODEL_H
#include <QAbstractListModel>
#include <QList>
#include <QJsonArray>
#include <QJsonObject>

class operatorModel : public QAbstractListModel
{

Q_OBJECT

public:

    bool remove(int row){
      return removeRow(row, QModelIndex());
    }

    explicit operatorModel(QObject* parent = nullptr)
        :_operatorModel(new QList<QJsonObject>())
    {
      Q_UNUSED(parent)
      _roleName[static_cast<int>(operatorColumnName::id)] = "id";
      _roleName[static_cast<int>(operatorColumnName::name)] = "name";
      _roleName[static_cast<int>(operatorColumnName::phoneNumber)] = "phoneNumber";
      _roleName[static_cast<int>(operatorColumnName::position)] = "position";
      _roleName[static_cast<int>(operatorColumnName::teamName)] = "teamName";
      _roleName[static_cast<int>(operatorColumnName::certification)] = "certification";
    };

    ~operatorModel(){}


    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    virtual int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    virtual QVariant data(const QModelIndex &index, int role) const override;
    bool removeRow(int row, const QModelIndex &parent);
    void setOperatorData(QJsonArray operatorData);

    enum operatorColumnName {
      name = Qt::UserRole,
      phoneNumber,
      position,
      teamName,
      certification,
      id
    };


protected:
    virtual QHash<int, QByteArray> roleNames() const override;
    QHash<int, QByteArray> _roleName;

private:
    QList<QJsonObject>* _operatorModel;
};

#endif // OPERATORMODEL_H
