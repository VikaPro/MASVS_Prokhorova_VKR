#include "projectsmodel.h"

#include <QDebug>

ProjectObject::ProjectObject(const QString &p_name,
                             const QString &p_create_date,
                             const QString &p_edit_date)
    : m_name(p_name),
      m_create_date(p_create_date),
      m_edit_date(p_edit_date)
{
}

ProjectsModel::ProjectsModel(QObject *parent)
    : QAbstractListModel(parent)
{

}

void ProjectsModel::addItem(const ProjectObject &newItem)
{
    // благодаря beginInsertRows() и endInsertRows() QML реагирует на изменения модели
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_items << newItem; // добавляем данные в модель
    endInsertRows();
}

int ProjectsModel::rowCount(const QModelIndex & parent) const
{
    // метод используется ListView в QML для определения числа элементов
    Q_UNUSED(parent);
    return m_items.count();
}

QVariant ProjectsModel::data(const QModelIndex & index, int role) const
{
    if (index.row() < 0 || (index.row() >= m_items.count()))
        return QVariant();

    const ProjectObject&itemToReturn = m_items[index.row()];

    if (role == name){
        return itemToReturn.getName();}

    else if (role == create_date)
        return itemToReturn.getCreateDate();

    else if (role == edit_date)
        return itemToReturn.getEditDate();

    return QVariant();
}


QHash<int, QByteArray> ProjectsModel::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[name] = "name";
    roles[create_date] = "create_date";
    roles[edit_date] = "edit_date";

    return roles;
}


void ProjectsModel::clearR()
{
    // благодаря beginInsertRows() и endInsertRows()
    // QML реагирует на изменения модели
    beginRemoveRows(QModelIndex(), 0, rowCount()-1);
    m_items.clear();    // очищаем модель
    endRemoveRows();
}

QString ProjectObject::getName() const
{
    return m_name;          // название проекта
}

QString ProjectObject::getCreateDate() const
{
    return m_create_date;   // дата создания проекта
}

QString ProjectObject::getEditDate() const
{
    return m_edit_date;     // дата изменения проекта
}
