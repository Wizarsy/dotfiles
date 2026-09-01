import Quickshell.Widgets
import QtQuick

import qs.Services

ClippingWrapperRectangle {
  id: clock
  color: "cyan"
  leftMargin: 15
  rightMargin: 15
  Text {
    anchors.fill: parent
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
    text: Qt.formatDateTime(Time.time, "ddd MMM d - hh:mm:ss AP")
  }
}
