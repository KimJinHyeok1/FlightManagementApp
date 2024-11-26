#include "aircraftregisterqml.h"

aircraftRegisterqml::aircraftRegisterqml(QObject *parent)
    : QAbstractItemModel(parent)
{
}

QVariant aircraftRegisterqml::headerData(int section, Qt::Orientation orientation, int role) const
{
    // FIXME: Implement me!
}

QModelIndex aircraftRegisterqml::index(int row, int column, const QModelIndex &parent) const
{
    // FIXME: Implement me!
}

QModelIndex aircraftRegisterqml::parent(const QModelIndex &index) const
{
    // FIXME: Implement me!
}

int aircraftRegisterqml::rowCount(const QModelIndex &parent) const
{
    if (!parent.isValid())
        return 0;

    // FIXME: Implement me!
}

int aircraftRegisterqml::columnCount(const QModelIndex &parent) const
{
    if (!parent.isValid())
        return 0;

    // FIXME: Implement me!
}

QVariant aircraftRegisterqml::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    // FIXME: Implement me!
    return QVariant();
}
