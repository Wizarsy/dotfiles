import QtQuick
import Quickshell
import Quickshell.Widgets

Item {
  id: root
  Rectangle {
    id: t
    z:1
    // anchors.fill: root
    // anchors.left: wrapper.left
    // anchors.right: wrapper.right
    // anchors.top: wrapper.top
    // anchors.margins: 8

    implicitHeight: labelText.contentHeight
    implicitWidth: labelText.contentWidth + 15
    color: "red"
    Text {
      id: labelText
      text: "teste"
      font.pixelSize: 24
      anchors.fill: parent
      horizontalAlignment: Text.AlignHCenter
    }
  } 
  ClippingWrapperRectangle {
    id: wrapper
    margin: 8
    topMargin: t.height
    border.width: 2
    Rectangle {
      id: wrapperContent
      implicitHeight: 200
      implicitWidth: 200
      color: "blue"
    } 
  }
}