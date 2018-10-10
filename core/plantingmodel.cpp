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

#include <QDebug>
#include <QDate>
#include <QVector>

#include "databaseutility.h"
#include "sqltablemodel.h"
#include "plantingmodel.h"

PlantingModel::PlantingModel(QObject *parent)
    : QSortFilterProxyModel(parent),
      m_model(new SqlTableModel(this)),
      m_string(""),
      m_year(QDate::currentDate().year()),
      m_season(1),
      m_sortColumn("crop"),
      m_sortOrder("ascending")
{
    m_model->setTable(plantingTableName);
    m_model->select();
    m_model->setSortColumn(m_sortColumn, m_sortOrder);
    setSourceModel(m_model);

    setFilterKeyColumn(-1);
    setFilterCaseSensitivity(Qt::CaseInsensitive);

//    int varietyColumn = fieldColumn("variety_id");
//    setRelation(varietyColumn, QSqlRelation("variety", "variety_id", "variety"));

//    select();
}

void PlantingModel::refresh() const
{
    m_model->select();
}

QString PlantingModel::filterString() const
{
    return m_string;
}

int PlantingModel::filterYear() const
{
    return m_year;
}

int PlantingModel::filterSeason() const
{
    return m_season;
}

QString PlantingModel::sortColumn() const
{
    return m_sortColumn;
}

QString PlantingModel::sortOrder() const
{
    return m_sortOrder;
}

void PlantingModel::setFilterYear(int year)
{
    m_year = year;
    filterYearChanged();
    invalidateFilter();
}

void PlantingModel::setFilterSeason(int season)
{
    if (0 <= season && season <= 3)
        m_season = season;
    else
        m_season = 1; // default to Spring

    filterSeasonChanged();
    invalidateFilter();
}

void PlantingModel::setSortColumn(const QString &columnName)
{
    m_sortColumn = columnName;
    m_model->setSortColumn(m_sortColumn, m_sortOrder);
    sortColumnChanged();
}

void PlantingModel::setSortOrder(const QString &order)
{
    m_sortOrder = order;
    m_model->setSortColumn(m_sortColumn, m_sortOrder);
    sortOrderChanged();
}

QVector<QDate> PlantingModel::seasonDates() const
{
    switch (m_season) {
    case 0: // Spring
        return {QDate(m_year-1, 10, 1), QDate(m_year, 11, 30)};
    case 2: // Fall
        return {QDate(m_year, 4, 1), QDate(m_year+1, 3, 31)};
    case 3: // Winter
        return {QDate(m_year, 7, 1), QDate(m_year+1, 6, 30)};
    default: // Summer or invalid season
        return {QDate(m_year, 1, 1), QDate(m_year, 12, 31)};
    }
}

QVariant PlantingModel::rowValue(int row, const QModelIndex &parent, const QString &field) const
{
    QModelIndex index = m_model->index(row, 0, parent);

    if (!index.isValid())
        return QVariant();

    return m_model->data(index, field).toString();
}

QDate PlantingModel::fieldDate(int row, const QModelIndex &parent, const QString &field) const
{
    QVariant value = rowValue(row, parent, field);
    if (value.isNull())
        return QDate();

    QString string = value.toString();
    return QDate::fromString(string, Qt::ISODate);
}

bool PlantingModel::isDateInRange(const QDate &date) const
{
    QVector<QDate> dates = seasonDates();
    QDate seasonBeg = dates[0];
    QDate seasonEnd = dates[1];

    return (seasonBeg <= date) && (date < seasonEnd);
}

bool PlantingModel::filterAcceptsRow(int sourceRow, const QModelIndex &sourceParent) const
{
    int dtt = rowValue(sourceRow, sourceParent, "dtt").toInt();
    int dtm = rowValue(sourceRow, sourceParent, "dtm").toInt();
    int harvestWindow = rowValue(sourceRow, sourceParent, "dtm").toInt();
    QDate plantingDate = fieldDate(sourceRow, sourceParent, "planting_date");
    QDate harvestBeginDate = plantingDate.addDays(dtm);
    QDate harvestEndDate = harvestBeginDate.addDays(harvestWindow);
    QDate seedingDate;

    auto plantingType = static_cast<PlantingType>(rowValue(sourceRow, sourceParent, "planting_type").toInt());
    if (plantingType == PlantingType::TransplantRaised)
        seedingDate = plantingDate.addDays(-dtt);
    else
        seedingDate = plantingDate;

    return (QSortFilterProxyModel::filterAcceptsRow(sourceRow, sourceParent)
            && (isDateInRange(seedingDate)
                || isDateInRange(plantingDate)
                || isDateInRange(harvestBeginDate)
                || isDateInRange(harvestEndDate)));
}
