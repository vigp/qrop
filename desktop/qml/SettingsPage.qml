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

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2
import Qt.labs.settings 1.0

import io.croplan.components 1.0

Page {
    id: page

    property bool showFamilyPane: false
    property int paneWidth: 600

    title: qsTr("Settings")
    Material.background: Material.color(Material.Grey, Material.Shade100)

    Settings {
        id: settings
        property alias farmName: farmNameField.text
        property string dateType
    }

    Column {
        width: paneWidth
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        spacing: Units.smallSpacing
        topPadding: Units.smallSpacing
        bottomPadding: topPadding

        Pane {
            width: parent.width
            height: 500
            Material.elevation: 2
            Material.background: "white"
            padding: 0

            ColumnLayout {
                anchors.fill: parent
                spacing: 0

                RowLayout {
                    Layout.minimumHeight: Units.rowHeight
                    Layout.leftMargin: Units.mediumSpacing
                    Layout.rightMargin: Layout.leftMargin

                    Label {
                        text: qsTr("Farm name")
                        font.family: "Roboto Regular"
                        font.pixelSize: Units.fontSizeBodyAndButton
                        Layout.fillWidth: true
                    }

                    TextInput {
                        id: farmNameField
                        font.family: "Roboto Regular"
                        font.pixelSize: Units.fontSizeBodyAndButton
                        Layout.minimumWidth: 200
                    }

                }

                ThinDivider { width: parent.width }

                RowLayout {
                    width: parent.width
                    Layout.leftMargin: Units.mediumSpacing
                    Layout.rightMargin: Layout.leftMargin

                    Label {
                        Layout.fillWidth: true
                        text: qsTr("Date type")
                        font.family: "Roboto Regular"
                        font.pixelSize: Units.fontSizeBodyAndButton
                    }

                    ComboBox {
                        Material.elevation: 0
                        font.family: "Roboto Regular"
                        font.pixelSize: Units.fontSizeBodyAndButton
                        Layout.minimumWidth: 200
                        currentIndex: settings.dateType == "week" ? 0 : 1
                        model: [qsTr("Week"), qsTr("Full")]
                        onCurrentTextChanged: {
                            if (currentIndex == 0)
                                settings.dateType = "week"
                            else
                                settings.dateType = "date"
                        }
                    }
                }

                ThinDivider { width: parent.width }

                RowLayout {
                    width: parent.width
                    Layout.leftMargin: Units.mediumSpacing
                    Layout.rightMargin: Layout.leftMargin

                    Label {
                        Layout.fillWidth: true
                        text: "Families, crops and varieties"
                        font.family: "Roboto Regular"
                        font.pixelSize: Units.fontSizeBodyAndButton
                    }

                    RoundButton {
                        text: "\ue315"
                        font.family: "Material Icons"
                        font.pixelSize: 22
                        flat: true
                        onClicked: showFamilyPane = true
                    }
                }

                ThinDivider { width: parent.width }

                RowLayout {
                    width: parent.width
                    Layout.leftMargin: Units.mediumSpacing
                    Layout.rightMargin: Layout.leftMargin

                    Label {
                        Layout.fillWidth: true
                        text: "Units"
                        font.family: "Roboto Regular"
                        font.pixelSize: Units.fontSizeBodyAndButton
                    }

                    RoundButton {
                        text: "\ue315"
                        font.family: "Material Icons"
                        font.pixelSize: 22
                        flat: true
//                        onClicked: showFamilyPane = true
                    }
                }

                ThinDivider { width: parent.width }

                RowLayout {
                    width: parent.width
                    Layout.leftMargin: Units.mediumSpacing
                    Layout.rightMargin: Layout.leftMargin

                    Label {
                        Layout.fillWidth: true
                        text: "Seed companies"
                        font.family: "Roboto Regular"
                        font.pixelSize: Units.fontSizeBodyAndButton
                    }

                    RoundButton {
                        text: "\ue315"
                        font.family: "Material Icons"
                        font.pixelSize: 22
                        flat: true
//                        onClicked: showFamilyPane = true
                    }
                }

                ThinDivider { width: parent.width }

                Item { Layout.fillHeight: true }

            }
        }
    }

    Pane {
        id: familyPane
        visible: showFamilyPane
        width: paneWidth
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        Material.elevation: 2
        Material.background: "white"
        padding: 0

        property int firstColumnWidth: 200
        property int secondColumnWidth: 150

        RowLayout {
            id: rowLayout
            spacing: Units.smallSpacing
            width: parent.width

            ToolButton {
                id: drawerButton
                text: "\ue5c4"
                font.family: "Material Icons"
                font.pixelSize: Units.fontSizeHeadline
                onClicked: showFamilyPane = false
                Layout.leftMargin: Units.formSpacing
            }

            Label {
                id: familyLabel
                text: qsTr("Families and crops")
                font.family: "Roboto Regular"
                font.pixelSize: Units.fontSizeSubheading
                Layout.fillWidth: true
            }

            Button {
                text: qsTr("Add family")
                flat: true
                Material.foreground: Material.accent
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter

            }

            Button {
                text: qsTr("Add crop")
                flat: true
                Material.foreground: Material.accent
                onClicked: addCropDialog.open();
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                Layout.rightMargin: Units.formSpacing

                AddCropDialog {
                    id: addCropDialog
                }
            }
        }

        Component {
            id: varietyDelegate
            Column {
                width: parent.width

                Rectangle {
                    height: childrenRect.height
                    width: parent.width

                    MouseArea {
                        id: varietyMouseArea
                        height: Units.rowHeight
                        width: parent.width
                        hoverEnabled: true

                        RowLayout {
                            id: varietyRow
                            height: Units.rowHeight
                            width: parent.width
                            spacing: Units.formSpacing

                            TextInput {
                                text: model.variety
                                color: Qt.rgba(0, 0, 0, 0.7)
                                font.family: "Roboto Regular"
                                Layout.leftMargin: Units.mediumSpacing + Units.formSpacing + Units.rowHeight * 0.8
                                Layout.minimumWidth: familyPane.firstColumnWidth

                                onEditingFinished: Variety.update(model.variety_id,
                                                                  {"variety": text})
                            }

                            ComboBox {
                                flat: true
                                Layout.minimumWidth: familyPane.secondColumnWidth
                                model: SeedCompanyModel {
                                }
                                textRole: "seed_company"

                            }

                            Item { height: 1; Layout.fillWidth: true }


                            MyToolButton {
                                height: parent.height * 0.8
                                visible: varietyMouseArea.containsMouse
                                text: enabled ? "\ue872" : ""
                                font.family: "Material Icons"
                                font.pixelSize: 22

                                ToolTip.text: qsTr("Remove variety")
                                ToolTip.visible: hovered
                                ToolTip.delay: 200

                                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                Layout.rightMargin: Units.formSpacing

                                onClicked: confirmVarietyDeleteDialog.open()

                                Dialog {
                                    id: confirmVarietyDeleteDialog
                                    title: qsTr("Delete %1?").arg(model.variety)
                                    standardButtons: Dialog.Ok | Dialog.Cancel

                                    Text {
                                        width: parent.width
                                        wrapMode: Text.WordWrap
                                        text: qsTr("All plantings will be lost.")
                                    }

                                    onAccepted: {
                                        Variety.remove(model.variety_id)
                                        varietyModel.refresh();
                                    }

                                    onRejected: confirmVarietyDeleteDialog.close()
                                }
                            }
                        }

                    }
                }

            }
        }

        ListView {
            anchors {
                top: rowLayout.bottom
                topMargin: Units.mediumSpacing
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }
            spacing: Units.smallSpacing
            model: FamilyModel {
                id: familyModel
            }

            delegate: familyDelegate
        }

        Component {
            id: cropDelegate
            Column {
                width: parent.width

                Rectangle {
                    id: delegate
                    height: childrenRect.height
                    width: parent.width

                    MouseArea {
                        id: cropMouseArea
                        height: Units.rowHeight
                        width: parent.width
                        hoverEnabled: true

                        RowLayout {
                            id: cropRow
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width
                            height: Units.rowHeight
                            spacing: Units.formSpacing

                            TextCheckBox {
                                id: checkBox
                                text: model.crop
                                selectionMode: false
                                Layout.leftMargin: Units.mediumSpacing
                                //                                width: 24
                                Layout.preferredWidth: Units.rowHeight * 0.8
                                round: true
                                color: model.color
                                //                                checked: model.planting_id in selectedIds && selectedIds[model.planting_id]
                            }

                            TextInput {
                                text: model.crop
                                font.family: "Roboto Regular"
                                Layout.minimumWidth: familyPane.firstColumnWidth
                                onEditingFinished: {
                                    Crop.update(model.crop_id, {"crop": text});
                                    model.refresh();
                                }
                            }

                            ComboBox {
                                flat: true
                                Layout.minimumWidth: familyPane.secondColumnWidth
                                model: UnitModel {
                                }
                                textRole: "fullname"
                            }

                            Item { height: 1; Layout.fillWidth: true }

                            MyToolButton {
                                visible: cropMouseArea.containsMouse
                                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                text: enabled ? "\ue872" : ""
                                font.family: "Material Icons"
                                font.pixelSize: 22
                                ToolTip.text: qsTr("Remove crop")
                                ToolTip.visible: hovered
                                ToolTip.delay: 200

                                onClicked: confirmCropDeleteDialog.open()

                                Dialog {
                                    id: confirmCropDeleteDialog
                                    title: qsTr("Delete %1?").arg(model.crop)
                                    standardButtons: Dialog.Ok | Dialog.Cancel

                                    Text {
                                        width: parent.width
                                        wrapMode: Text.WordWrap
                                        text: qsTr("All plantings will be lost.")
                                    }

                                    onAccepted: {
                                        Crop.remove(model.crop_id)
                                        cropModel.refresh();
                                    }

                                    onRejected: confirmCropDeleteDialog.close()
                                }
                            }

                            MyToolButton {
                                id: showVarietiesButton
                                Layout.leftMargin: -28
                                Layout.rightMargin: Units.mediumSpacing
                                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                checkable: true
                                text: checked ?  "\ue313" : "\ue315"
                                font.family: "Material Icons"
                                font.pixelSize: 22
                                ToolTip.text: checked ? qsTr("Hide varieties") : qsTr("Show varieties")
                                ToolTip.visible: hovered
                                ToolTip.delay: 200
                            }
                        }

                    }
                }

                ListView {
                    spacing: 0
                    visible: showVarietiesButton.checked
                    width: parent.width
                    height: contentHeight

                    model: VarietyModel {
                        id: cropModel
                        cropId: crop_id
                    }

                    delegate: varietyDelegate
                }

                Button {
                    visible: showVarietiesButton.checked
                    id: addVarietyButton
                    anchors.right: parent.right
                    anchors.rightMargin: Units.mediumSpacing
                    flat: true
                    text: qsTr("Add variety")
                    onClicked: addVarietyDialog.open();

                    AddVarietyDialog {
                        id: addVarietyDialog
                        onAccepted: {
                            if (seedCompanyId > 0)
                                Variety.add({"variety" : varietyName,
                                                "crop_id" : model.crop_id,
                                                "seed_company_id" : seedCompanyId});
                            else
                                Variety.add({"variety" : varietyName,
                                                "crop_id" : model.crop_id});

                            model.refresh();
                        }
                    }
                }
            }
        }

        Component {
            id: familyDelegate
            Column {
                width: parent.width

                Rectangle {
                    color: Material.color(Material.Grey, Material.Shade100)
                    width: parent.width
                    height: childrenRect.height

                    MouseArea {
                        id: familyMouseArea
                        height: Units.rowHeight
                        width: parent.width
                        hoverEnabled: true

                        RowLayout {
                            id: headerRow
                            anchors.verticalCenter: parent.verticalCenter
                            width: parent.width
                            height: Units.rowHeight
                            spacing: Units.formSpacing

                            TextCheckBox {
                                id: headerCheckbox
                                text: family
                                selectionMode: false
                                color: model.color
                                Layout.preferredWidth: Units.rowHeight * 0.8
                                round: true
                                MouseArea {
                                    anchors.fill: parent
                                }
                                Layout.leftMargin: Units.mediumSpacing
                            }

                            TextInput {
                                text: family
                                font.family: "Roboto Regular"
                                font.pixelSize: Units.fontSizeBodyAndButton
                                Layout.minimumWidth: familyPane.firstColumnWidth
                                onEditingFinished: {
                                    Family.update(family_id, {"family": text})
                                    familyModel.refresh();
                                }

                            }

                            ComboBox {
                                flat: true
                                model: 10
                                Layout.minimumWidth: familyPane.secondColumnWidth
                                currentIndex: interval
                                font.family: "Roboto Regular"
                                font.pixelSize: Units.fontSizeBodyAndButton
                                displayText: qsTr("%L1 years", "", currentIndex).arg(currentIndex)
                                onCurrentIndexChanged: Family.update(family_id, {"interval": currentIndex})

                                ToolTip.text: qsTr("Minimum rotation interval for %1").arg(family)
                                ToolTip.visible: hovered
                                ToolTip.delay: 200
                            }


                            Item { Layout.fillWidth: true }

                            MyToolButton {
                                visible: familyMouseArea.containsMouse
                                text: enabled ? "\ue872" : ""
                                font.family: "Material Icons"
                                font.pixelSize: 22
                                ToolTip.text: qsTr("Remove family")
                                ToolTip.visible: hovered
                                ToolTip.delay: 200
                                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter

                                onClicked: confirmFamilyDeleteDialog.open()

                                Dialog {
                                    id: confirmFamilyDeleteDialog
                                    title: qsTr("Delete %1?").arg(family)
                                    standardButtons: Dialog.Ok | Dialog.Cancel

                                    Text {
                                        width: parent.width
                                        wrapMode: Text.WordWrap
                                        text: qsTr("All crops and plantings will be lost.")
                                    }

                                    onAccepted: {
                                        Family.remove(family_id)
                                        familyModel.refresh();
                                    }

                                    onRejected: confirmFamilyDeleteDialog.close()
                                }
                            }

                            MyToolButton {
                                id: showCropsButton
                                Layout.leftMargin: -28
                                Layout.rightMargin: Units.mediumSpacing
                                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                checkable: true
                                text: checked ?  "\ue313" : "\ue315"
                                font.family: "Material Icons"
                                font.pixelSize: 22
                                ToolTip.text: checked ? qsTr("Hide crops") : qsTr("Show crop")
                                ToolTip.visible: hovered
                                ToolTip.delay: 200
                            }
                        }
                    }
                }

                ListView {
                    spacing: 0
                    visible: showCropsButton.checked
                    width: parent.width
                    height: contentHeight

                    model: CropModel {
                        id: cropModel
                        familyId: family_id
                    }

                    delegate: cropDelegate
                }

            }
        }
    }



    //        ListView {
    //            id: cropListView
    //            clip: true
    //            spacing: Units.smallSpacing
    //            anchors {
    //                top: rowLayout.bottom
    //                topMargin: Units.mediumSpacing
    //                left: parent.left
    //                right: parent.right
    //                bottom: parent.bottom
    //            }

    //            model: CropModel {
    //                id: cropModel
    //                sortColumn: "family_id"
    //            }

    //            section.property: "family_id"
    //            section.delegate: Rectangle {
    //                id: sectionDelegate
    //                color: Material.color(Material.Grey, Material.Shade200)
    //                height: headerRow.height
    //                width: parent.width

    //                MouseArea {
    //                    id: sectionMouseArea
    //                    anchors.fill: parent
    //                    hoverEnabled: true

    //                    Row {
    //                        id: headerRow
    //                        width: parent.width
    //                        height: Units.rowHeight
    //                        spacing: Units.formSpacing
    //                        leftPadding: Units.mediumSpacing

    //                        TextCheckBox {
    //                            id: headerCheckbox
    //                            text: Family.name(section)
    //                            selectionMode: false
    //                            anchors.verticalCenter: headerRow.verticalCenter
    //                            color: Family.color(section)
    //                            //                                width: 24
    //                            width: Units.rowHeight * 0.8
    //                            round: true
    //                            //                                color:
    //                            //                                checked: model.planting_id in selectedIds && selectedIds[model.planting_id]

    //                            MouseArea {
    //                                anchors.fill: parent
    //                            }
    //                        }

    //                        TextInput {
    //                            text: Family.name(section)
    //                            font.family: "Roboto Regular"
    //                            font.pixelSize: Units.fontSizeBodyAndButton
    //                            anchors.verticalCenter: parent.verticalCenter
    //                            width: 200
    //                            onEditingFinished: {
    //                                Family.update(section, {"family": text})
    //                                cropModel.refresh();
    //                            }

    //                        }

    //                        ComboBox {
    //                            flat: true
    //                            model: 10
    //                            width: 200
    //                            currentIndex: Family.interval(section)
    //                            font.family: "Roboto Regular"
    //                            font.pixelSize: Units.fontSizeBodyAndButton
    //                            displayText: qsTr("%L1 years", "", currentIndex).arg(currentIndex)
    //                            onCurrentIndexChanged: Family.update(section, {"interval": currentIndex})
    //                            anchors.verticalCenter: parent.verticalCenter

    //                            ToolTip.text: qsTr("Minimum rotation interval for %1").arg(Family.name(section))
    //                            ToolTip.visible: hovered
    //                            ToolTip.delay: 200
    //                        }
    //                    }
    //                }
    //            }

    //            delegate: Rectangle {
    //                id: delegate
    //                height: column.height
    //                width: parent.width
    //                border.color: Material.color(Material.Grey, Material.Shade400)
    //                border.width: mouseArea.containsMouse ? 1 : 0

    //                MouseArea {
    //                    id: mouseArea
    //                    anchors.fill: parent
    //                    hoverEnabled: true

    //                    Column {
    //                        id: column
    //                        width: parent.width
    //                        anchors.verticalCenter: parent.verticalCenter

    //                        RowLayout {
    //                            id: row
    //                            height: Units.rowHeight
    //                            width: parent.width
    //                            spacing: Units.formSpacing
    //                            Layout.alignment: Qt.AlignTop

    //                            TextCheckBox {
    //                                id: checkBox
    //                                text: model.crop
    //                                selectionMode: false
    //                                Layout.leftMargin: Units.mediumSpacing
    //                                //                                width: 24
    //                                Layout.preferredWidth: Units.rowHeight * 0.8
    //                                round: true
    //                                color: model.color
    //                                //                                checked: model.planting_id in selectedIds && selectedIds[model.planting_id]
    //                            }

    //                            TextInput {
    //                                text: model.crop
    //                                font.family: "Roboto Regular"
    //                                Layout.minimumWidth: 200
    //                                Layout.fillWidth: true
    //                                onEditingFinished: {
    //                                    Crop.update(model.crop_id, {"crop": text});
    //                                    cropModel.refresh();
    //                                }
    //                            }

    //                            MyToolButton {
    //                                visible: mouseArea.containsMouse
    //                                text: enabled ? "\ue872" : ""
    //                                font.family: "Material Icons"
    //                                font.pixelSize: 22
    //                                ToolTip.text: qsTr("Remove crop")
    //                                ToolTip.visible: hovered
    //                                ToolTip.delay: 200

    //                                onClicked: confirmCropDeleteDialog.open()

    //                                Dialog {
    //                                    id: confirmCropDeleteDialog
    //                                    title: qsTr("Delete %1?").arg(model.crop)
    //                                    standardButtons: Dialog.Ok | Dialog.Cancel

    //                                    Text {
    //                                        width: parent.width
    //                                        wrapMode: Text.WordWrap
    //                                        text: qsTr("All plantings will be lost.")
    //                                    }

    //                                    onAccepted: {
    //                                        Crop.remove(model.crop_id)
    //                                        cropModel.refresh();
    //                                    }

    //                                    onRejected: confirmCropDeleteDialog.close()
    //                                }
    //                            }

    //                            MyToolButton {
    //                                id: varietyButton
    //                                visible: mouseArea.containsMouse || checked
    //                                Layout.leftMargin: -28
    //                                Layout.rightMargin: Units.mediumSpacing
    //                                checkable: true
    //                                text: checked ?  "\ue313" : "\ue315"
    //                                font.family: "Material Icons"
    //                                font.pixelSize: 22
    //                                //                            enabled: model.task_type_id > 3
    //                                //                            onClicked: {
    //                                //                                Task.remove(model.task_id);
    //                                //                                page.refresh();
    //                                //                            }
    //                                ToolTip.text: checked ? qsTr("Hide varieties") : qsTr("Show varieties")
    //                                ToolTip.visible: hovered
    //                                ToolTip.delay: 200
    //                            }
    //                        }

    //                        ListView {
    //                            id: varietyView
    //                            visible: varietyButton.checked
    //                            width: parent.width
    //                            height: contentHeight
    //                            model: VarietyModel {
    //                                id: varietyModel
    //                                cropId:  model.crop_id
    //                            }

    //                            delegate: Rectangle {
    //                                id: varietyDelegate
    //                                height: varietyColumn.height
    //                                width: parent.width

    //                                MouseArea {
    //                                    id: varietyMouseArea
    //                                    anchors.fill: parent
    //                                    hoverEnabled: true

    //                                    Column {
    //                                        id: varietyColumn
    //                                        width: parent.width

    //                                        RowLayout {
    //                                            id: varietyRow
    //                                            height: Units.rowHeight
    //                                            width: parent.width
    //                                            spacing: Units.formSpacing

    //                                            TextInput {
    //                                                text: model.variety
    //                                                color: Qt.rgba(0, 0, 0, 0.7)
    //                                                font.family: "Roboto Regular"
    //                                                Layout.leftMargin: Units.mediumSpacing + Units.formSpacing + Units.rowHeight * 0.8
    //                                                Layout.minimumWidth: 200

    //                                                onEditingFinished: Variety.update(model.variety_id,
    //                                                                                  {"variety": text})
    //                                            }

    //                                            ComboBox {
    //                                                flat: true
    //                                                Layout.minimumWidth: 200
    //                                                model: SeedCompanyModel {
    //                                                }
    //                                                textRole: "seed_company"

    //                                            }

    //                                            Item { Layout.fillWidth:  true }

    //                                            MyToolButton {
    //                                                height: parent.height * 0.8
    //                                                visible: varietyMouseArea.containsMouse
    //                                                text: enabled ? "\ue872" : ""
    //                                                font.family: "Material Icons"
    //                                                font.pixelSize: 22
    //                                                //                            enabled: model.task_type_id > 3
    //                                                //                            onClicked: {
    //                                                //                                Task.remove(model.task_id);
    //                                                //                                page.refresh();
    //                                                //                            }
    //                                                ToolTip.text: qsTr("Remove variety")
    //                                                ToolTip.visible: hovered
    //                                                ToolTip.delay: 200

    //                                                onClicked: confirmVarietyDeleteDialog.open()

    //                                                Dialog {
    //                                                    id: confirmVarietyDeleteDialog
    //                                                    title: qsTr("Delete %1?").arg(model.variety)
    //                                                    standardButtons: Dialog.Ok | Dialog.Cancel

    //                                                    Text {
    //                                                        width: parent.width
    //                                                        wrapMode: Text.WordWrap
    //                                                        text: qsTr("All plantings will be lost.")
    //                                                    }

    //                                                    onAccepted: {
    //                                                        Variety.remove(model.variety_id)
    //                                                        varietyModel.refresh();
    //                                                    }

    //                                                    onRejected: confirmVarietyDeleteDialog.close()
    //                                                }
    //                                            }

    //                                            MyToolButton {
    //                                                enabled: false
    //                                                visible: varietyMouseArea.containsMouse
    //                                                Layout.leftMargin: -28
    //                                                Layout.rightMargin: Units.mediumSpacing
    //                                                checkable: true
    //                                                text: ""
    //                                                font.family: "Material Icons"
    //                                                font.pixelSize: 22
    //                                                //                            enabled: model.task_type_id > 3
    //                                                //                            onClicked: {
    //                                                //                                Task.remove(model.task_id);
    //                                                //                                page.refresh();
    //                                                //                            }
    //                                                ToolTip.text: checked ? qsTr("Hide varieties") : qsTr("Show varieties")
    //                                                ToolTip.visible: hovered
    //                                                ToolTip.delay: 200
    //                                            }
    //                                        }

    //                                    }
    //                                }
    //                            }
    //                        }

    //                        Button {
    //                            id: addVarietyButton
    //                            visible: varietyButton.checked
    //                            anchors.right: parent.right
    //                            anchors.rightMargin: Units.mediumSpacing
    //                            flat: true
    //                            text: qsTr("Add variety")
    //                            onClicked: addVarietyDialog.open();

    //                            AddVarietyDialog {
    //                                id: addVarietyDialog
    //                                onAccepted: {
    //                                    if (seedCompanyId > 0)
    //                                        Variety.add({"variety" : varietyName,
    //                                                        "crop_id" : model.crop_id,
    //                                                        "seed_company_id" : seedCompanyId});
    //                                    else
    //                                        Variety.add({"variety" : varietyName,
    //                                                        "crop_id" : model.crop_id});

    //                                    varietyModel.refresh();
    //                                }
    //                            }
    //                        }
    //                    }
    //                }
    //            }
    //        }

}
