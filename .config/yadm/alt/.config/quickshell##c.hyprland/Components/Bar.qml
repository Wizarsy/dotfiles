import QtQuick
import QtQuick.Layouts

import Quickshell

import qs.Components.Widgets

PanelWindow { // qmllint disable uncreatable-type
    id: root
    color: "transparent"
    implicitHeight: 30
    margins { // qmllint disable unqualified unresolved-type
        top: 10
        left: 10
        right: 10
    }
    anchors {
        top: true
        left: true
        right: true
    }
    Rectangle {
        id: bar
        anchors.fill: parent
        radius: 15
        color: "black"
        RowLayout {
            id: barLayout
            spacing: 100
            anchors.fill: parent
            anchors.leftMargin: 5
            anchors.rightMargin: 5
            Rectangle {
                id: lefZone
                color: "transparent"
                Layout.fillWidth: true
                Layout.preferredHeight: root.implicitHeight
                border {
                    color: "white"
                }
            }
            Rectangle {
                id: centerZone
                color: "transparent"
                Layout.fillWidth: true
                Layout.preferredHeight: root.implicitHeight
                border {
                    color: "white"
                }
                Clock {
                    implicitHeight: parent.height
                    anchors.centerIn: parent
                }
            }
            Rectangle {
                id: rightZone
                color: "transparent"
                Layout.fillWidth: true
                Layout.preferredHeight: root.implicitHeight
                border {
                    color: "white"
                }
                Row {
                    id: rightZoneLayout
                    anchors.fill: parent
                    layoutDirection: Qt.RightToLeft
                    spacing: 12

                    SysTray {}
                }
            }
        }
    }
}
