import UIKit

let hourGapToClock = 80 as Double
let minuteGapToClock = 50 as Double

class HandsView : UIView {
  var hourHand: UIView
  var minuteHand: UIView
  
  class func createHand() -> UIView {
    let view = UIView(frame: CGRect())
    view.backgroundColor = UIColor.blueColor()
    view.layer.opacity = 0.5
    view.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
    view.hidden = true
    return view
  }
  
  init(frame: CGRect) {
    hourHand = HandsView.createHand()
    minuteHand = HandsView.createHand()
    
    super.init(frame: frame)
    
    addSubview(hourHand)
    addSubview(minuteHand)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let radius = min(frame.width, frame.height) / 2
    let hourHandLength = radius - hourGapToClock
    let minuteHandLength = radius - minuteGapToClock

    hourHand.bounds = CGRect(x: 0, y: 0, width: 8, height: hourHandLength)
    hourHand.center = CGPoint(x: radius, y: radius)
    
    minuteHand.bounds = CGRect(x: 0, y: 0, width: 4, height: minuteHandLength)
    minuteHand.center = CGPoint(x: radius, y: radius)
  }
  
  var clockTime: ClockTime? {
  didSet {
    if let clockTime = clockTime {
      hourHand.hidden = false
      HandsView.rotateHand(hourHand, toNumber: clockTime.hour)

      minuteHand.hidden = !Bool(clockTime.minute)
      if let minute = clockTime.minute {
        HandsView.rotateHand(minuteHand, toNumber: minute)
      }
    } else {
      hourHand.hidden = true
      minuteHand.hidden = true
    }
  }
  }
  
  class func rotateHand(hand: UIView, toNumber: ClockNumber) {
    hand.transform = CGAffineTransformMakeRotation(toNumber.angleInRadians)
  }
}