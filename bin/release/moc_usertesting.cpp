/****************************************************************************
** Meta object code from reading C++ file 'usertesting.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.13.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../../usertesting.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'usertesting.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.13.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_UserTesting_t {
    QByteArrayData data[14];
    char stringdata0[130];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_UserTesting_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_UserTesting_t qt_meta_stringdata_UserTesting = {
    {
QT_MOC_LITERAL(0, 0, 11), // "UserTesting"
QT_MOC_LITERAL(1, 12, 12), // "showUserCard"
QT_MOC_LITERAL(2, 25, 0), // ""
QT_MOC_LITERAL(3, 26, 6), // "number"
QT_MOC_LITERAL(4, 33, 11), // "description"
QT_MOC_LITERAL(5, 45, 5), // "index"
QT_MOC_LITERAL(6, 51, 11), // "colUserTest"
QT_MOC_LITERAL(7, 63, 3), // "col"
QT_MOC_LITERAL(8, 67, 10), // "allTestEnd"
QT_MOC_LITERAL(9, 78, 8), // "userTest"
QT_MOC_LITERAL(10, 87, 7), // "oneCard"
QT_MOC_LITERAL(11, 95, 10), // "resultUser"
QT_MOC_LITERAL(12, 106, 6), // "result"
QT_MOC_LITERAL(13, 113, 16) // "incompleteChecks"

    },
    "UserTesting\0showUserCard\0\0number\0"
    "description\0index\0colUserTest\0col\0"
    "allTestEnd\0userTest\0oneCard\0resultUser\0"
    "result\0incompleteChecks"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_UserTesting[] = {

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
       1,    3,   49,    2, 0x06 /* Public */,
       6,    1,   56,    2, 0x06 /* Public */,
       8,    0,   59,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       9,    0,   60,    2, 0x0a /* Public */,
      10,    1,   61,    2, 0x0a /* Public */,
      11,    4,   64,    2, 0x0a /* Public */,
      13,    1,   73,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::Int,    3,    4,    5,
    QMetaType::Void, QMetaType::Int,    7,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,    5,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::Int,    3,    4,   12,    5,
    QMetaType::Void, QMetaType::Int,    5,

       0        // eod
};

void UserTesting::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<UserTesting *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->showUserCard((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3]))); break;
        case 1: _t->colUserTest((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 2: _t->allTestEnd(); break;
        case 3: _t->userTest(); break;
        case 4: _t->oneCard((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 5: _t->resultUser((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3])),(*reinterpret_cast< int(*)>(_a[4]))); break;
        case 6: _t->incompleteChecks((*reinterpret_cast< int(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (UserTesting::*)(QString , QString , int );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&UserTesting::showUserCard)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (UserTesting::*)(int );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&UserTesting::colUserTest)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (UserTesting::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&UserTesting::allTestEnd)) {
                *result = 2;
                return;
            }
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject UserTesting::staticMetaObject = { {
    &QObject::staticMetaObject,
    qt_meta_stringdata_UserTesting.data,
    qt_meta_data_UserTesting,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *UserTesting::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *UserTesting::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_UserTesting.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int UserTesting::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
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
void UserTesting::showUserCard(QString _t1, QString _t2, int _t3)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t2))), const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t3))) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void UserTesting::colUserTest(int _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void UserTesting::allTestEnd()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
