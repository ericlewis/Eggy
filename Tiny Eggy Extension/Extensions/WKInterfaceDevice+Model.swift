import WatchKit

enum WatchResolution {
    case
    w38mm,
    w40mm,
    w42mm,
    w44mm,
    unknown
}

extension WKInterfaceDevice {
class func model() -> WatchResolution {
    let watch38mmRect = CGRect(x: 0, y: 0, width: 136, height: 170)
    let watch40mmRect = CGRect(x: 0, y: 0, width: 162, height: 197)
    let watch42mmRect = CGRect(x: 0, y: 0, width: 156, height: 195)
    let watch44mmRect = CGRect(x: 0, y: 0, width: 184, height: 224)

    let currentBounds = WKInterfaceDevice.current().screenBounds

    switch currentBounds {
    case watch38mmRect:
        return .w38mm
    case watch40mmRect:
        return .w40mm
    case watch42mmRect:
        return .w42mm
    case watch44mmRect:
        return .w44mm
    default:
        return .unknown
    }
  }
}
