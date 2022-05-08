#ifndef PERMISSIONMODEL_H
#define PERMISSIONMODEL_H

#include <QObject>
#include <QAbstractListModel>

class PermissionObject
{
public:
    PermissionObject(const QString &p_name,
                     const QString &p_level);

    QString getName() const;
    QString getLevel() const;

private:
    QString m_name;
    QString m_level;
};


class PermissionModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum enmRoles {
        name = Qt::UserRole + 1,
        level
    };

    PermissionModel(QObject *parent = nullptr);

    void addItem(const PermissionObject & newItem);

    int rowCount(const QModelIndex & parent = QModelIndex()) const;

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

public slots:
    void clearR();

protected:
    QHash<int, QByteArray> roleNames() const; // "ключ" - значение

private:
    QList<PermissionObject> m_items;

};

#endif // PERMISSIONMODEL_H

