import "../../Services"
import Quickshell
import QtQuick

Text {
  required property string format
  text: Qt.formatDateTime(Time.time, format)
}
