import UIKit

let clockViewNumberFont = UIFont(name: "HelveticaNeue-Light", size: 32.0)
let clockViewTouchBufferAroundNumber = 10 as Double

class ClockView : UIView {
  var clock: Clock!
  var numberViews = Dictionary<Clock.Number, UILabel>()
  var currentlyTouchingNumber: Clock.Number?
  
  class var numberSize: CGSize {
    var largestString = Clock.Number.Twelve.toRaw().description as NSString
    return largestString.sizeWithAttributes([NSFontAttributeName: clockViewNumberFont])
  }
  
  class var numberLength: Double {
    return max(ClockView.numberSize.width, self.numberSize.height)
  }
  
  class var clockCenterOffset: Double {
    return clockViewTouchBufferAroundNumber + self.numberLength / 2
  }
  
  class func createNumberLabel() -> UILabel {
    var label = UILabel(frame: CGRect(origin: CGPoint(), size: self.numberSize))
    label.font = clockViewNumberFont
    label.textAlignment = NSTextAlignment.Center
    label.textColor = UIColor.blackColor()
    return label
  }

  init(frame: CGRect) {
    super.init(frame: frame)

    self.userInteractionEnabled = true
    
    for number in Clock.Number.allNumbers {
      var label = ClockView.createNumberLabel()
      label.text = number.toRaw().description

      addSubview(label)
      numberViews[number] = label
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()

    let radius = min(frame.width, frame.height) / 2 - ClockView.clockCenterOffset
    clock = Clock(radius: radius)
    
    let clockCenter = CGPoint(x: radius + ClockView.clockCenterOffset, y: radius + ClockView.clockCenterOffset)
    
    for (number, label) in numberViews {
      let numberSize = label.frame.size
      let numberOffset = clock.offSetFromClockCenter(number)
      
      var numberOrigin = clockCenter
      numberOrigin.x += numberOffset.x - numberSize.width / 2
      numberOrigin.y += numberOffset.y - numberSize.height / 2
      label.frame.origin = numberOrigin
    }
  }
  
  var clockTouchOuterRadius: Double {
    return clock.radius + ClockView.numberLength / 2 + clockViewTouchBufferAroundNumber
  }
  
  var clockTouchInnerRadius: Double {
    return clock.radius - ClockView.numberLength / 2 - clockViewTouchBufferAroundNumber
  }
  
  func numberFromTouch(touch: UITouch) -> Clock.Number? {
    var location = touch.locationInView(self)
    location.x -= ClockView.clockCenterOffset
    location.y -= ClockView.clockCenterOffset
    let centerOffset = clock.centerOffsetFromOriginOffset(originOffset: location)
    let distanceFromCenter = clock.distanceFromCenter(offsetFromCenter: centerOffset)
    if distanceFromCenter > clockTouchInnerRadius && distanceFromCenter < clockTouchOuterRadius {
      return clock.numberFromOffset(offsetFromCenter: centerOffset)
    }
    return nil
  }
  
  override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
    if touches.count != 1 {
      return
    }
    
    let touch = touches.anyObject() as UITouch
    let possibleNumber = numberFromTouch(touch)
    if let number = possibleNumber {
      currentlyTouchingNumber = number
      println("touched on \(number.toRaw())")
    }
  }

  override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {
    if touches.count != 1 || !currentlyTouchingNumber {
      return
    }
    
    let touch = touches.anyObject() as UITouch
    let possibleNumber = numberFromTouch(touch)
    if let number = possibleNumber {
      if number != currentlyTouchingNumber {
        println("moved to \(number.toRaw())")
        currentlyTouchingNumber = number
      }
    }
  }

  override func touchesEnded(touches: NSSet!, withEvent event: UIEvent!) {
    if touches.count != 1 || !currentlyTouchingNumber {
      return
    }
    
    let touch = touches.anyObject() as UITouch
    let possibleNumber = numberFromTouch(touch)
    if let number = possibleNumber {
      println("ended on \(number.toRaw())")
    }
    currentlyTouchingNumber = nil
  }
}