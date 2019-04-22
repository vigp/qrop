import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0
import Qt.labs.settings 1.0
import Qt.labs.platform 1.0 as Platform

import io.qrop.components 1.0

Button {
    id: control
    checkable: true

    property bool manuallyModified: false
    property color checkedColor: Material.color(Material.Indigo, Material.Shade400)
    property color focusCheckedColor: Material.color(Material.Indigo, Material.Shade300)
    property color activeFocusColor: Material.color(Material.Grey, Material.Shade500)
    property color hoveredColor: Material.color(Material.Grey, Material.Shade400)
    property color defaultColor: Material.color(Material.Grey, Material.Shade300)

    property bool hasFocus: false

    font { family: "Roboto Regular"; pixelSize: 14; capitalization: Font.MixedCase }

    contentItem: Text {
        anchors.verticalCenter: control.verticalCenter
        verticalAlignment: Qt.AlignVCenter

        color: checked ? "white " : Material.accent
        text: control.text
        font: control.font

        ColorAnimation on color {
            duration: 2000
        }
    }


    background: Rectangle {
        implicitHeight: Units.chipHeight
        anchors.verticalCenter: control.verticalCenter
        radius: 0
        color: checked ? (hasFocus ? focusCheckedColor : checkedColor)
                       : hasFocus ? activeFocusColor
                                  : hovered ? hoveredColor
                                            : defaultColor
        ColorAnimation on color {
            duration: 2000
        }
    }
}