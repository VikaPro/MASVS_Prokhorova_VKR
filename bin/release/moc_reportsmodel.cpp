/****************************************************************************
** Meta object code from reading C++ file 'reportsmodel.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.13.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../../reportsmodel.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'reportsmodel.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.13.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_ReportsModel_t {
    QByteArrayData data[11];
    char stringdata0[101];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_ReportsModel_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_ReportsModel_t qt_meta_stringdata_ReportsModel = {
    {
QT_MOC_LITERAL(0, 0, 12), // "ReportsModel"
QT_MOC_LITERAL(1, 13, 12), // "endExportCSV"
QT_MOC_LITERAL(2, 26, 0), // ""
QT_MOC_LITERAL(3, 27, 12), // "endExportPDF"
QT_MOC_LITERAL(4, 40, 8), // "sendName"
QT_MOC_LITERAL(5, 49, 4), // "name"
QT_MOC_LITERAL(6, 54, 6), // "clearR"
QT_MOC_LITERAL(7, 61, 9), // "exportCSV"
QT_MOC_LITERAL(8, 71, 8), // "fileName"
QT_MOC_LITERAL(9, 80, 9), // "exportPDF"
QT_MOC_LITERAL(10, 90, 10) // "createHTML"

    },
    "ReportsModel\0endExportCSV\0\0endExportPDF\0"
    "sendName\0name\0clearR\0exportCSV\0fileName\0"
    "exportPDF\0createHTML"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_ReportsModel[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       7,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       3,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   49,    2, 0x06 /* Public */,
       3,    0,   50,    2, 0x06 /* Public */,
       4,    1,   51,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       6,    0,   54,    2, 0x0a /* Public */,
       7,    1,   55,    2, 0x0a /* Public */,
       9,    1,   58,    2, 0x0a /* Public */,
      10,    0,   61,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,    5,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,    8,
    QMetaType::Void, QMetaType::QString,    8,
    QMetaType::QString,

       0        // eod
};

void ReportsModel::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<ReportsModel *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->endExportCSV(); break;
        case 1: _t->endExportPDF(); break;
        case 2: _t->sendName((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 3: _t->clearR(); break;
        case 4: _t->exportCSV((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 5: _t->exportPDF((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 6: { QString _r = _t->createHTML();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (ReportsModel::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ReportsModel::endExportCSV)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (ReportsModel::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ReportsModel::endExportPDF)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (ReportsModel::*)(QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ReportsModel::sendName)) {
                *result = 2;
                return;
            }
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject ReportsModel::staticMetaObject = { {
    &QAbstractListModel::staticMetaObject,
    qt_meta_stringdata_ReportsModel.data,
    qt_meta_data_ReportsModel,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *ReportsModel::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *ReportsModel::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_ReportsModel.stringdata0))
        return static_cast<void*>(this);
    return QAbstractListModel::qt_metacast(_clname);
}

int ReportsModel::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QAbstractListModel::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 7)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 7;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 7)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 7;
    }
    return _id;
}

// SIGNAL 0
void ReportsModel::endExportCSV()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void ReportsModel::endExportPDF()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void ReportsModel::sendName(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
