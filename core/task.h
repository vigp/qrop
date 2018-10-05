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

#ifndef TASK_H
#define TASK_H

#include "core_global.h"
#include "databaseutility.h"

class CORESHARED_EXPORT Task : public DatabaseUtility {
    Q_OBJECT
public:
    Task(QObject *parent = nullptr);
    Q_INVOKABLE QList<int> sowPlantTaskIds(int plantingId) const;
    Q_INVOKABLE void addPlanting(int plantingId, int taskId) const;
    Q_INVOKABLE void removePlanting(int plantingId, int taskId) const;
    Q_INVOKABLE void createTasks(int plantingId, const QDate &plantingDate) const;
    Q_INVOKABLE QList<int> plantingTasks(int plantingId) const;
    Q_INVOKABLE void updateTaskDates(int plantingId, const QDate &plantingDate) const;
    Q_INVOKABLE void duplicatePlantingTasks(int sourcePlantingId, int newPlantingId) const;
    Q_INVOKABLE void removePlantingTasks(int plantingId) const;

    Q_INVOKABLE void addLocation(int locationId, int taskId) const;
    Q_INVOKABLE void removeLocation(int locationId, int taskId) const;
    Q_INVOKABLE QList<int> locationTasks(int locationId) const;
    Q_INVOKABLE void duplicateLocationTasks(int sourceLocationId, int newLocationId) const;
    Q_INVOKABLE void removeLocationTasks(int locationId) const;

    Q_INVOKABLE void applyTemplate(int templateId, int plantingId) const;
    Q_INVOKABLE void removeTemplate(int templateId, int plantingId) const;

private:
    QList<int> templateTasks(int templateId) const;
};

#endif // TASK_H