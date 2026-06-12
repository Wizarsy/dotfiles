pragma Singleton

import Quickshell
import QtQuick

Singleton {
  property alias time: clock.date
  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}
