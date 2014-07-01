import Foundation

enum ClockNumber : Int {
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
    return Double(self.toRaw()) * ClockNumber.degreesBetweenNumbers % 360
  }
  
  var angleInRadians: Double {
    return self.angleInDegrees * M_PI / 180
  }
  
  static func numberFromAngle(radians: Double) -> ClockNumber {
    var number = Int(floor((radians + ClockNumber.radiansBetweenNumbers / 2) / ClockNumber.radiansBetweenNumbers)) % ClockNumber.allNumbers.count
    if number == 0 {
      number = 12
    }
    return ClockNumber.fromRaw(number)!
  }
}