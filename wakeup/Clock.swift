import CoreGraphics

struct Clock {

  enum Number : Int {
    case
    One = 1,
    Two,
    Three,
    Four,
    Five,
    Six,
    Seven,
    Eight,
    Nine,
    Ten,
    Eleven,
    Twelve
    
    static let allNumbers = [One, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Eleven, Twelve]
    
    static let degreesBetweenNumbers: Double = 30
    static let radiansBetweenNumbers = degreesBetweenNumbers * M_PI / 180
    
    var angleInDegrees: Double {
      return Double(self.toRaw()) * Number.degreesBetweenNumbers
    }
    
    var angleInRadians: Double {
      return self.angleInDegrees * M_PI / 180
    }
    
    static func numberFromAngle(radians: Double) -> Number {
      var number = Int(floor((radians + Number.radiansBetweenNumbers / 2) / Number.radiansBetweenNumbers)) % Number.allNumbers.count
      if number == 0 {
        number = 12
      }
      return Number.fromRaw(number)!
    }
  }
  
  var radius: Double
  
  func offSetFromClockCenter(number: Number) -> CGPoint {
    let angle = number.angleInRadians
    return CGPoint(x: sin(angle) * radius, y: -cos(angle) * radius)
  }
  
  func centerOffsetFromOriginOffset(originOffset offset: CGPoint) -> CGPoint {
    return CGPoint(x: offset.x - radius, y: offset.y - radius)
  }
  
  func distanceFromCenter(offsetFromCenter offset: CGPoint) -> Double {
    return sqrt(pow(offset.x, 2) + pow(offset.y, 2))
  }
  
  func numberFromOffset(offsetFromCenter offset: CGPoint) -> Number? {
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
    
    return Number.numberFromAngle(angle)
  }
}

