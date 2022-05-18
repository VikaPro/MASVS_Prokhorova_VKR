#ifndef PROJECTSMODEL_H
#define PROJECTSMODEL_H

#include <QObject>
#include <QAbstractListModel>

class ProjectObject
{
public:
    ProjectObject(const QString &p_name,
                  const QString &p_create_date,
                  const QString &p_edit_date,
                  const QString &p_input_data,
                  const QString &p_path_apk,
                  const QString &p_level);

    QString getName() const;
    QString getCreateDate() const;
    QString getEditDate() const;
    QString getInputData() const;
    QString getPathAPK() const;
    QString getLevel() const;

private:
    QString m_name;
    QString m_create_date;
    QString m_edit_date;
    QString m_input_data;
    QString m_path_apk;
    QString m_level;
};

class ProjectsModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum enmRoles {
        name = Qt::UserRole + 1,
        create_date,
        edit_date,
        input_data,
        path_apk,
        level
    };

    ProjectsModel(QObject *parent = nullptr);

    void addItem(const ProjectObject & newItem);

    int rowCount(const QModelIndex & parent = QModelIndex()) const;

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

public slots:
    void clearR();

protected:
    QHash<int, QByteArray> roleNames() const; // "ключ" - значение

private:
    QList<ProjectObject> m_items;
};

#endif // PROJECTSMODEL_H
