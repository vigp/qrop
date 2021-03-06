/*
 * Copyright (C) 2018-2019 André Hoarau <ah@ouvaton.org>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <QDate>
#include <QSqlRecord>
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>

#include "sqltablemodel.h"

SqlTableModel::SqlTableModel(QObject *parent)
    : QSqlTableModel(parent)
{
    setEditStrategy(QSqlTableModel::OnManualSubmit);
}

bool SqlTableModel::select()
{
    bool status = QSqlTableModel::select();

    if (!status)
        return status;

    // Fetch as much as possible.
    while (canFetchMore())
        fetchMore();

    return status;
}

bool SqlTableModel::insertRecord(int row, const QSqlRecord &record)
{
    bool ok = QSqlTableModel::insertRecord(row, record);
    if (!ok)
        qWarning() << "Couldn't insert record" << record
                   << "in database:" << query().lastError().text();
    return ok;
}

QVariant SqlTableModel::data(const QModelIndex &index, int role) const
{
    if (role < Qt::UserRole)
        return QSqlTableModel::data(index, role);

    const auto &sqlRecord = record(index.row());
    const auto &value = sqlRecord.value(role - Qt::UserRole);
    const auto &date = QDate::fromString(value.toString(), Qt::ISODate);
    if (date.isValid()) // fromString(string) returns invalid date if string cannot be parsed
        return date;
    return value;
}

QVariant SqlTableModel::data(const QModelIndex &index, const QString &role) const
{
    const auto &it = m_rolesIndexes.constFind(role);
    if (it == m_rolesIndexes.constEnd())
        return {};
    return data(index, it.value());
}

int SqlTableModel::fieldColumn(const QString &field) const
{
    const auto &it = m_rolesIndexes.constFind(field);
    if (it == m_rolesIndexes.constEnd())
        return -1;
    return m_rolesIndexes[field];
}

QHash<int, QByteArray> SqlTableModel::roleNames() const
{
    QHash<int, QByteArray> roles;

    for (int i = 0; i < this->record().count(); i++)
        roles.insert(Qt::UserRole + i, record().fieldName(i).toUtf8());

    return roles;
}

// order must be "ascending" or "descending"
void SqlTableModel::setSortColumn(const QString &fieldName, const QString &order)
{
    if (!m_rolesIndexes.contains(fieldName)) {
        qDebug() << "m_rolesIndexes doesn't have key" << fieldName << roleIndex(fieldName);
        return;
    }
    setSort(roleIndex(fieldName), order == "ascending" ? Qt::AscendingOrder : Qt::DescendingOrder);
    select();
}

void SqlTableModel::setTable(const QString &tableName)
{
    QSqlTableModel::setTable(tableName);
    buildRolesIndexes();
    select();
}

bool SqlTableModel::submitAll()
{
    bool ok = QSqlTableModel::submitAll();
    if (!ok)
        qFatal("Cannot submit pending changes to database: %s", qPrintable(lastError().text()));

    return ok;
}

int SqlTableModel::roleIndex(const QString &role) const
{
    if (!m_rolesIndexes.contains(role))
        return -1;
    return m_rolesIndexes[role] - Qt::UserRole;
}

void SqlTableModel::buildRolesIndexes()
{
    for (int i = 0; i < this->record().count(); i++)
        m_rolesIndexes.insert(record().fieldName(i).toUtf8(), Qt::UserRole + i);
}
