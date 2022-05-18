#ifndef REPORTSMODEL_H
#define REPORTSMODEL_H

#include <QObject>
#include <QAbstractListModel>

class ReportObject
{
public:
    ReportObject(const QString &p_number,
                 const QString &p_description,
                 const QString &p_result,
                 const QString &p_function);

    QString getNumber() const;
    QString getDescription() const;
    QString getResult() const;
    QString getFunction() const;

private:
    QString m_number;
    QString m_description;
    QString m_result;
    QString m_function;
};

class ReportsModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum enmRoles {
        number = Qt::UserRole + 1,
        description,
        result,
        function
    };

    ReportsModel(QObject *parent = nullptr);

    void addItem(const ReportObject & newItem);

    int rowCount(const QModelIndex & parent = QModelIndex()) const;

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;

public slots:
    void clearR();

    // экспорт отчёта в формат csv
    void exportCSV(QString fileName);

    // экспорт отчёта в формат pdf
    void exportPDF(QString fileName);

    // генерация странички отчёта на html
    QString createHTML();

signals:
    // сигнал об окончании записи отчёта в файл CSV
    void endExportCSV();

    // сигнал об окончании печати документа PDF
    void endExportPDF();




protected:
    QHash<int, QByteArray> roleNames() const; // "ключ" - значение

private:
    QList<ReportObject> m_items;
};

#endif // REPORTSMODEL_H
