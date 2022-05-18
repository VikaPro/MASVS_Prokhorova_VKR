#include "projectsmodel.h"

#include <QDebug>
#include <QFile>

ProjectObject::ProjectObject(const QString &p_name,
                             const QString &p_create_date,
                             const QString &p_edit_date,
                             const QString &p_input_data,
                             const QString &p_path_apk,
                             const QString &p_level)
    : m_name(p_name),
      m_create_date(p_create_date),
      m_edit_date(p_edit_date),
      m_input_data(p_input_data),
      m_path_apk(p_path_apk),
      m_level(p_level)
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

    qDebug() << "Добавляю модель";
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

    else if (role == input_data)
        return itemToReturn.getInputData();

    else if (role == path_apk)
        return itemToReturn.getPathAPK();

    else if (role == level)
        return itemToReturn.getLevel();

    return QVariant();
}


QHash<int, QByteArray> ProjectsModel::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[name] = "name";
    roles[create_date] = "create_date";
    roles[edit_date] = "edit_date";
    roles[input_data] = "input_data";
    roles[path_apk] = "path_apk";
    roles[level] = "level";

    return roles;
}


void ProjectsModel::clearR()
{
    // благодаря beginInsertRows() и endInsertRows()
    // QML реагирует на изменения модели

    // очищаем только в том случае, если модель не пустая
    if (this->rowCount() != 0){
        beginRemoveRows(QModelIndex(), 0, rowCount()-1);
        m_items.clear();    // очищаем модель
        endRemoveRows();
    }
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

QString ProjectObject::getInputData() const
{
    return m_input_data;    // тип входных данных
}

QString ProjectObject::getPathAPK() const
{
    return m_path_apk;      // путь к файлу apk
}

QString ProjectObject::getLevel() const
{
    return m_level;         // уровень безопасности для анализа
}
