#pragma once

#include <QAbstractListModel>
#include <qqml.h>

class CppDefinedModel : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT

    enum {
        TextRole = Qt::UserRole,
        ValueRole,
        IconUrlRole
    };

public:
    using QAbstractListModel::QAbstractListModel;

    int rowCount(const QModelIndex &parent) const override
    {
        return 6;
    }
    QVariant data(const QModelIndex &index, int role) const override
    {
        switch (role)
        {
        case TextRole:    return QString("name%0").arg(index.row());
        case ValueRole:   return QString("value%0").arg(index.row());
        case IconUrlRole: return QString("qrc:/comboboxtests/icons/%0.png")
                    .arg(std::array<const char *,3>{{"movinghead", "nebelmaschine", "rgbstrahler"}}[index.row() / 2 % 3]);
        }
        return {};
    }
    QHash<int, QByteArray> roleNames() const override
    {
        return {{TextRole, "theText"}, {ValueRole, "theValue"}, {IconUrlRole, "theIconUrl"}};
    }
};
