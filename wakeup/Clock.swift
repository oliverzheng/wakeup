import CoreGraphics

struct Clock {

  var radius: Double
  
  func offSetFromClockCenter(number: ClockNumber) -> CGPoint {
    let angle = number.angleInRadians
    return CGPoint(x: sin(angle) * radius, y: -cos(angle) * radius)
  }
  
  func centerOffsetFromOriginOffset(originOffset offset: CGPoint) -> CGPoint {
    return CGPoint(x: offset.x - radius, y: offset.y - radius)
  }
  
  func distanceFromCenter(offsetFromCenter offset: CGPoint) -> Double {
    return sqrt(pow(offset.x, 2) + pow(offset.y, 2))
  }
  
  func numberFromOffset(offsetFromCenter offset: CGPoint) -> ClockNumber? {
    // This is a cartesian angle that goes clockwise
    var angle: Double

    switch (offset.x, offset.y) {
    case (0, 0):
      return nil
    case (0, let y) where y > 0:
      angle = M_PI_2
    case (0, let y) where y < 0:
      angle = -M_PI_2
    case (let x, 0) where x > 0:
      angle = 0
    case (let x, 0) where x < 0:
      angle = M_PI
    case let (x, y) where x > 0:
      angle = atan(offset.y / offset.x)
    case let (x, y) where x < 0:
      angle = atan(offset.y / offset.x) + M_PI
    default:
      return nil;
    }
    
    angle = angle + M_PI_2
    if angle > M_PI * 2 {
      angle -= M_PI * 2
    }
    
    return ClockNumber.numberFromAngle(angle)
  }
}

