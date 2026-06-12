import Quickshell
import QtQuick

Rectangle {
  id: leftZone
  anchors.left: parent.left
  anchors.top: parent.top
  anchors.bottom: parent.bottom
  anchors.leftMargin: 5
  anchors.topMargin: 5
  anchors.bottomMargin: 5
  height: 20
  width: bar.width / 3
  border {
    color: "black"
  }
}