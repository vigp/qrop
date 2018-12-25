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

#ifndef SORTFILTERPROXYMODEL_H
#define SORTFILTERPROXYMODEL_H

#include <QObject>
#include <QSortFilterProxyModel>

#include "core_global.h"

class SqlTableModel;

class CORESHARED_EXPORT SortFilterProxyModel : public QSortFilterProxyModel
{
    Q_OBJECT
    Q_PROPERTY(QString filterString READ filterString WRITE setFilterFixedString NOTIFY filterStringChanged)
    Q_PROPERTY(int year READ filterYear() WRITE setFilterYear NOTIFY filterYearChanged)
    Q_PROPERTY(int season READ filterSeason() WRITE setFilterSeason NOTIFY filterSeasonChanged)
    Q_PROPERTY(QString sortColumn READ sortColumn WRITE setSortColumn NOTIFY sortColumnChanged)
    Q_PROPERTY(QString sortOrder READ sortOrder WRITE setSortOrder NOTIFY sortOrderChanged)
    Q_PROPERTY(int count READ rowCount() NOTIFY countChanged)

public:
    SortFilterProxyModel(QObject *parent = nullptr, const QString &tableName = "");

    Q_INVOKABLE QList<int> idList() const;
    Q_INVOKABLE int rowId(int row) const;
    Q_INVOKABLE void resetFilter() { invalidateFilter(); }
    Q_INVOKABLE virtual void refresh();

    QString filterString() const;
    int filterYear() const;
    int filterSeason() const;
    QString sortColumn() const;
    QString sortOrder() const;

    void setFilterYear(int year);
    void setFilterSeason(int season);
    void setSortColumn(const QString &columnName);
    void setSortOrder(const QString &order);

protected:
    SqlTableModel *m_model;
    bool isDateInRange(const QDate &date) const;
    QVariant rowValue(int row, const QModelIndex &parent, const QString &field) const;
    QDate fieldDate(int row, const QModelIndex &parent, const QString &field) const;
    QPair<QDate, QDate> seasonDates() const;
    QPair<QDate, QDate> seasonDates(int season, int year) const;
    int m_year;
    int m_season;

private:
    QString m_tableName;
    QString m_string;
    QString m_sortColumn;
    QString m_sortOrder;

signals:
    void filterStringChanged();
    void filterYearChanged();
    void filterSeasonChanged();
    void sortColumnChanged();
    void sortOrderChanged();
    void selectionChanged();
    void countChanged();
};

#endif // SORTFILTERPROXYMODEL_H
