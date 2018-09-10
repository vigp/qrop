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

#ifndef KEYWORDMODEL_H
#define KEYWORDMODEL_H

#include <QObject>

#include "core_global.h"
#include "sqltablemodel.h"

class KeywordModel : public SqlTableModel
{
    Q_OBJECT

public:
    KeywordModel(QObject *parent = nullptr);
};

#endif // KEYWORDMODEL_H
