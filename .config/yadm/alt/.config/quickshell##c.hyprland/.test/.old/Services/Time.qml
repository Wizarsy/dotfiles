pragma Singleton

import Quickshell
import QtQuick

Singleton {
  property string time: clock.date
  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }
}
