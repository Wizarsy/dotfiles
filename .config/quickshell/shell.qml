import Quickshell
import QtQuick

import qs.Components

ShellRoot {
    id: root
    Variants {
        model: Quickshell.screens
        Scope {
            id: scope
            required property var modelData
            Bar {
                screen: scope.modelData
            }
        }
    }
    OSD {}
}
