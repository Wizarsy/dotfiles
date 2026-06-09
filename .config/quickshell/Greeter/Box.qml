import QtQuick
import Quickshell

Rectangle {
  property string labelText
  property int labelSize
  property string labelPos
  property color textColor
  property int borderSize
  property int borderColor
  property Component content
  
  id: root
  implicitWidth: content.implicitWidth
  implicitHeight: content.implicitHeight

  Rectangle {
    id: labelBox
    visible: (!! root.labelText) && (labelText.contentWidth + 30 < borderBox.width)
    z: 1
    color: root.color
    height: labelText.contentHeight
    width: labelText.contentWidth + 15
    state: root.labelPos
    states: [
      State {
        name: "topLeft"
        AnchorChanges {
          target: labelBox
          anchors.left: innerBox.left
        }
        PropertyChanges {
          target: labelBox
          anchors.leftMargin: 5
        }
      },
      State {
        name: "topCenter"
        AnchorChanges {
          target: labelBox
          anchors.horizontalCenter: root.horizontalCenter
        }
      },
      State {
        name: "topRight"
        AnchorChanges {
          target: labelBox
          anchors.right: innerBox.right
        }
        PropertyChanges {
          target: labelBox
          anchors.rightMargin: 5
        }
      },
      State {
        name: "bottomLeft"
        AnchorChanges {
          target: labelBox
          anchors.left: innerBox.left
          anchors.bottom: root.bottom
        }
        PropertyChanges {
          target: labelBox
          anchors.leftMargin: 5
        }
      },
      State {
        name: "bottomCenter"
        AnchorChanges {
          target: labelBox
          anchors.horizontalCenter: root.horizontalCenter
          anchors.bottom: root.bottom
        }
      },
      State {
        name: "bottomRight"
        AnchorChanges {
          target: labelBox
          anchors.right: innerBox.right
          anchors.bottom: root.bottom
        }
        PropertyChanges {
          target: labelBox
          anchors.rightMargin: 5
        }
      }
    ]
    Text {
      id: labelText
      text: root.labelText
      font.pixelSize: root.labelSize
      anchors.fill: labelBox
      horizontalAlignment: Text.AlignHCenter
    }
  }
  Rectangle {
    id: borderBox
    color: "transparent"
    border { color: "black"; width: 2 }
    anchors.fill: root
    anchors.margins: 8
    anchors.topMargin: (root.labelPos.startsWith("top") && labelText.visible) ? labelText.contentHeight / 2 : undefined
    anchors.bottomMargin: (root.labelPos.startsWith("bottom") && labelText.visible) ? labelText.contentHeight / 2: undefined
    Loader {
      id: content
      anchors.fill: borderBox
      clip: true
      anchors.margins: 8
      anchors.topMargin: (root.labelPos.startsWith("top") && labelText.visible) ? labelText.contentHeight / 2 : undefined
      anchors.bottomMargin: (root.labelPos.startsWith("bottom") && labelText.visible) ? labelText.contentHeight / 2: undefined
      sourceComponent: root.content
    }
  }
}
