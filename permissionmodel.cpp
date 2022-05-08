#include "permissionmodel.h"

#include <QDebug>


PermissionObject::PermissionObject(const QString &p_name,
                             const QString &p_level)
    : m_name(p_name),
      m_level(p_level)
{
}


PermissionModel::PermissionModel(QObject *parent)
    : QAbstractListModel(parent)
{

}

void PermissionModel::addItem(const PermissionObject &newItem)
{
    // благодаря beginInsertRows() и endInsertRows() QML реагирует на изменения модели
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_items << newItem; // добавляем данные в модель
    endInsertRows();
}

int PermissionModel::rowCount(const QModelIndex & parent) const
{
    // метод используется ListView в QML для определения числа элементов
    Q_UNUSED(parent);
    return m_items.count();
}

QVariant PermissionModel::data(const QModelIndex & index, int role) const
{
    if (index.row() < 0 || (index.row() >= m_items.count()))
        return QVariant();

    const PermissionObject&itemToReturn = m_items[index.row()];

    if (role == name){
        return itemToReturn.getName();}

    else if (role == level)
        return itemToReturn.getLevel();

    return QVariant();
}


QHash<int, QByteArray> PermissionModel::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[name] = "name";
    roles[level] = "level";

    return roles;
}


void PermissionModel::clearR()
{
    // благодаря beginInsertRows() и endInsertRows()
    // QML реагирует на изменения модели
    beginRemoveRows(QModelIndex(), 0, rowCount()-1);
    m_items.clear();    // очищаем модель
    endRemoveRows();
}

QString PermissionObject::getName() const
{
    return m_name;          // название проекта
}

QString PermissionObject::getLevel() const
{
    return m_level;     // дата изменения проекта
}
