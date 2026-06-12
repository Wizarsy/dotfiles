import qs.Components.Bar
import Quickshell
import QtQuick

ShellRoot {
  Variants {
    model: Quickshell.screens;
    delegate: Component {
      Scope {
        required property var modelData
        Bar {}
      }
    }
  } 
}