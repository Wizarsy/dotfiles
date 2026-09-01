import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Greetd

ShellRoot {
  id: root
  FloatingWindow {
    // exclusionMode: ExclusionMode.Ignore
    // WlrLayershell.layer: WlrLayer.Overlay
    // WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
    // anchors { left: true; top: true; right: true; bottom: true }
    // Box {
    //   id: b1
    //   anchors.fill: parent
    //   labelText: "08:24:54 - Sab Abr 14"
    //   labelSize: 24
    //   labelPos: "topCenter"
    //   content: ColumnLayout{
    //     spacing: 25
    //     anchors.fill: parent
    //     anchors.topMargin: 400
    //     Rectangle {
    //       Layout.alignment: Qt.AlignCenter
    //       color: "red"
    //       Layout.preferredWidth: 200
    //       Layout.preferredHeight: 200
    //     }
    //     Rectangle {
    //       Layout.alignment: Qt.AlignCenter
    //       color: "blue"
    //       Layout.preferredWidth: 400
    //       Layout.preferredHeight: 50
    //     }
    //     Rectangle {
    //       Layout.alignment: Qt.AlignCenter
    //       color: "blue"
    //       Layout.preferredWidth: 400
    //       Layout.preferredHeight: 50
    //       Layout.bottomMargin: 400
    //     }
    //     RowLayout {
    //       spacing: 25
    //       anchors.right: parent.right
    //       anchors.bottom: parent.bottom
    //       // anchors.fill: parent
    //       // Item {
    //       //   Layout.alignment: Qt.AlignLeft
    //       //   Layout.preferredWidth: 400
    //       //   Layout.preferredHeight: 50
    //       // }
    //       Rectangle {
    //         anchors.left: parent.left
    //         // Layout.alignment: Qt.AlignLeft
    //         color: "yellow"
    //         Layout.preferredWidth: 400
    //         Layout.preferredHeight: 50
    //       }
    //       Rectangle {
    //         // Layout.alignment: Qt.AlignRight
    //         color: "yellow"
    //         Layout.preferredWidth: 400
    //         Layout.preferredHeight: 50
    //       }
    //     }
    //   }
    // }

    Box2 {
      id: b2
      anchors.fill: parent 
      anchors.margins: 8 
    }
  }
}