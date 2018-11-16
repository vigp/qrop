/*
 * Copyright (C) 2018 André Hoarau <ah@ouvaton.org>
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
#include <QDebug>

#include "sortfilterproxymodel.h"
#include "sqltablemodel.h"

SortFilterProxyModel::SortFilterProxyModel(QObject *parent, const QString &tableName)
    : QSortFilterProxyModel(parent),
      m_model(new SqlTableModel(this)),
      m_tableName(tableName),
      m_string(""),
      m_year(QDate::currentDate().year()),
      m_season(1),
      m_sortColumn(""),
      m_sortOrder("ascending")
{
    m_model->setTable(tableName);
    m_model->select();
    setSourceModel(m_model);
    setSortLocaleAware(true);

    setFilterKeyColumn(-1);
    setFilterCaseSensitivity(Qt::CaseInsensitive);

//    int varietyColumn = fieldColumn("variety_id");
//    setRelation(varietyColumn, QSqlRelation("variety", "variety_id", "variety"));

//    select();
}

QList<int> SortFilterProxyModel::idList() const
{
    QList<int> list;
    for (int row = 0; row < rowCount(); row++) {
        QModelIndex idx = index(row, 0);
        QModelIndex sourceIndex = mapToSource(idx);
        int id = m_model->data(sourceIndex, "planting_id").toInt();
        list.append(id);
    }
    qDebug() << "idList:" << list;
    return list;
}

int SortFilterProxyModel::rowId(int row) const
{
    QModelIndex idx = index(row, 0);
    QModelIndex sourceIndex = mapToSource(idx);
    int id = m_model->data(sourceIndex, Qt::UserRole).toInt();
    return id;
}


void SortFilterProxyModel::refresh() const
{
    m_model->select();
    countChanged();
}

QString SortFilterProxyModel::filterString() const
{
    return m_string;
}

int SortFilterProxyModel::filterYear() const
{
    return m_year;
}

int SortFilterProxyModel::filterSeason() const
{
    return m_season;
}

QString SortFilterProxyModel::sortColumn() const
{
    return m_sortColumn;
}

QString SortFilterProxyModel::sortOrder() const
{
    return m_sortOrder;
}

void SortFilterProxyModel::setFilterYear(int year)
{
    m_year = year;
    filterYearChanged();
    invalidateFilter();
}

void SortFilterProxyModel::setFilterSeason(int season)
{
    if (0 <= season && season <= 3)
        m_season = season;
    else
        m_season = 1; // default to Spring

    filterSeasonChanged();
    invalidateFilter();
}

void SortFilterProxyModel::setSortColumn(const QString &columnName)
{
    m_sortColumn = columnName;
    sort(m_model->roleIndex(m_sortColumn), m_sortOrder == "ascending" ? Qt::AscendingOrder
                                                                      : Qt::DescendingOrder);
    sortColumnChanged();
}

void SortFilterProxyModel::setSortOrder(const QString &order)
{
    m_sortOrder = order;
    sort(m_model->roleIndex(m_sortColumn), m_sortOrder == "ascending" ? Qt::AscendingOrder
                                                                      : Qt::DescendingOrder);
    sortOrderChanged();
}

QVector<QDate> SortFilterProxyModel::seasonDates() const
{
    switch (m_season) {
    case 0: // Spring
        return {QDate(m_year-1, 10, 1), QDate(m_year, 9, 30)};
    case 2: // Fall
        return {QDate(m_year, 4, 1), QDate(m_year+1, 3, 31)};
    case 3: // Winter
        return {QDate(m_year, 7, 1), QDate(m_year+1, 6, 30)};
    default: // Summer or invalid season
        return {QDate(m_year, 1, 1), QDate(m_year, 12, 31)};
    }
}

QVariant SortFilterProxyModel::rowValue(int row, const QModelIndex &parent, const QString &field) const
{
    QModelIndex index = m_model->index(row, 0, parent);

    if (!index.isValid())
        return QVariant();

    return m_model->data(index, field).toString();
}

QDate SortFilterProxyModel::fieldDate(int row, const QModelIndex &parent, const QString &field) const
{
    QVariant value = rowValue(row, parent, field);
    if (value.isNull())
        return {};

    QString string = value.toString();
    return QDate::fromString(string, Qt::ISODate);
}

bool SortFilterProxyModel::isDateInRange(const QDate &date) const
{
    QVector<QDate> dates = seasonDates();
    QDate seasonBeg = dates[0];
    QDate seasonEnd = dates[1];

    return (seasonBeg <= date) && (date < seasonEnd);
}