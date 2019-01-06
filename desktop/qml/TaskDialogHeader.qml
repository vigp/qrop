import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2

import io.croplan.components 1.0

Rectangle {
    id: control

    property int taskId: -1
    readonly property int taskTypeId: taskTypeModel.rowId(typeComboBox.currentIndex)
    property string completedDate: ""
    readonly property bool completed: completedDate
    property alias typeField: typeComboBox
    property int week
    property int year
    property bool sowPlantTask: false
    property alias typeComboBox: typeComboBox

    function reset() {
        typeComboBox.currentIndex = 0;
        completedDate = "";
        taskTypeModel.refresh();
    }

    focus: true
    implicitHeight: 60
    color: Material.color(Material.Grey, Material.Shade200)
    radius: 2
    clip: true
    Material.elevation: 2

    TaskTypeModel {
        id: taskTypeModel
        showPlantingTasks: sowPlantTask
    }

    RowLayout {
        id: rowLayout
        anchors.fill: parent
        spacing: Units.smallSpacing
        anchors {
            leftMargin: Units.mediumSpacing
            rightMargin: anchors.leftMargin
            topMargin: Units.smallSpacing
            bottomMargin: anchors.topMargin
        }

        Rectangle {
            id: textIcon
            Layout.alignment: Qt.AlignVCenter
            height: 40
            width: height
            radius: 80
            border.width: 2
            border.color: Material.color(Material.Green, Material.Shade400)

            Text {
                anchors.centerIn: parent
                text: {
                    var stringList =  typeComboBox.currentText.split(" ");
                    if (stringList.length > 1)
                        return stringList[0][0] + stringList[1][0].toString().toUpperCase()
                    else
                        return stringList[0][0] + stringList[0][1]
                }
                color: "black"
                font { family: "Roboto Regular"; pixelSize: 20 }
            }
        }

        MyComboBox {
            id: typeComboBox
            labelText: qsTr("Type")
            floatingLabel: true
            editable: false
            model: taskTypeModel
            showAddItem: true
            enabled: !sowPlantTask
            addItemText: qsTr("Add Type")
            textRole: "type"
            Layout.fillWidth: true

            onAddItemClicked: addTypeDialog.open()

            SimpleAddDialog {
                id: addTypeDialog
                validator: RegExpValidator { regExp: /\w[\w\d- ]*/ }
                title: qsTr("Add Type")
                onAccepted:  {
                    TaskType.add({"type" : text});

                    taskTypeModel.refresh();
                    typeComboBox.currentIndex = typeComboBox.find(text);
                }
            }
        }

        TaskCompleteButton {
            id: taskCompleteButton
            done: control.completedDate

            ToolTip.text: control.completedDate
                          ? qsTr("Done on %1. Click to undo.").arg(Date.fromLocaleDateString(Qt.locale(), control.completedDate, "yyyy-MM-dd").toLocaleDateString(Qt.locale(), Locale.ShortFormat))
                          : qsTr("Click to complete task. Hold to select date.")
            ToolTip.visible: hovered

            onClicked: {
                if (checked)
                    control.completedDate = new Date().toLocaleDateString(Qt.locale(), "yyyy-MM-dd");
                else
                    control.completedDate = ""
            }

            onPressAndHold: calendarPopup.open();

            Popup {
                id: calendarPopup

                width: contentItem.width
                height: contentItem.height
                y: parent.width - calendarView.height
                x: parent.height - calendarView.width
                closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
                padding: 0
                margins: 0

                contentItem: CalendarView {
                    id: calendarView

                    clip: true
                    year: page.year
                    month: (new Date()).getMonth()

                    onDateSelect: {
                        completedDate = newDate.toLocaleDateString(Qt.locale(), "yyyy-MM-dd");
                        calendarPopup.close();
                    }
                }
            }
        }



        //        ColumnLayout {
        //            Label {
        //                text: qsTr("Revenue")
        //                font { family: "Roboto Regular"; pixelSize: Units.fontSizeCaption }
        //                color: Qt.rgba(0,0,0, 0.50)
        //                Layout.alignment: Qt.AlignRight
        //            }
        //            Label {
        //                id: estimatedRevenueLabel
        //                text: "%L1 €".arg(estimatedRevenue)
        //                horizontalAlignment: Text.AlignHCenter
        //                font { family: "Roboto Regular"; pixelSize: Units.fontSizeBodyAndButton }
        //                color: Qt.rgba(0,0,0, 0.87)
        //                Layout.alignment: Qt.AlignRight
        //            }
        //        }
    }
}