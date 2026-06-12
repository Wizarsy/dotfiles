pragma ComponentBehavior: Bound

import QtQuick

import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray

Rectangle {
    id: root
    property int iconSize: 16
    implicitWidth: iconSize * 6
    implicitHeight: parent.height - 8
    color: "gray"
    radius: 15
    border {
        color: "white"
    }
    anchors.verticalCenter: parent.verticalCenter
    ListView {
        id: list
        clip: true
        spacing: 5
        anchors.fill: parent
        anchors.leftMargin: 2
        anchors.rightMargin: 2
        boundsBehavior: Flickable.StopAtBounds
        orientation: ListView.Horizontal
        model: SystemTray.items
        delegate: IconImage {
            id: icon
            required property var modelData
            implicitSize: root.iconSize
            source: modelData.icon
            anchors.verticalCenter: parent ? parent.verticalCenter : undefined
            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.MiddleButton | Qt.RightButton
                onClicked: mouse => {
                    if (mouse.button == Qt.LeftButton)
                        parent.modelData.activate();
                    else if (mouse.button == Qt.RightButton)
                        loader.active = !loader.active;
                    else
                        parent.modelData.secondaryActivate();
                }
            }
            LazyLoader {
                id: loader
                active: false
                PopupWindow {
                    id: menu
                    anchor.item: icon
                    anchor.rect.y: icon.height
                    implicitWidth: 120
                    implicitHeight: 12 + menuItems.height
                    visible: true
                    ListView {
                        id: menuItems
                        anchors.fill: parent
                        model: opener.children
                        delegate: Text {
                            id: popText
                            required property var modelData
                            text: modelData.text
                        }
                    }
                    QsMenuOpener {
                        id: opener
                        menu: icon.modelData.menu
                    }
                }
            }
        }
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.NoButton
            onWheel: wheel => {
                list.flick(-wheel.angleDelta.y * 30, 0);
                wheel.accepted = true;
            }
        }
    }
}
