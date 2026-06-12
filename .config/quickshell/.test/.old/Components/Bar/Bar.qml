import Quickshell
import QtQuick
import QtQuick.Layouts

PanelWindow {
  id: barRoot
  color: "transparent"
  implicitHeight: 35
  margins {
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
    radius: 12
    RowLayout {
      id: barLayout
      spacing: 100
      anchors.fill: parent
      anchors.leftMargin: 5
      anchors.rightMargin: 5
      Repeater {
        id: rep
        model: [Qt.AlignLeft, Qt.AlignHCenter, Qt.AlignRight]
        Rectangle {
          required property int index
          required property var modelData
          Layout.preferredWidth: barLayout.width / rep.count - barLayout.spacing
          Layout.preferredHeight: 20
          Layout.alignment: modelData
          border {
            color: "black"
          }
          Text { text: parent.width }
        }
      }
    }
  }
}