import UIKit

class MainViewController: UIViewController, ClockViewDelegate {
  
  @IBOutlet var clockContainerView: UIView

  override func viewDidLoad() {
    super.viewDidLoad()

    var clockFrame = self.clockContainerView.frame
    clockFrame.origin = CGPoint(x: 0, y: 0)
    
    let clockView = ClockView(frame: clockFrame)
    clockView.delegate = self
    clockContainerView.addSubview(clockView)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // ClockViewDelegate
  
  func touchingTime(clockView: ClockView, time: ClockTime)  {
    clockView.handsView.clockTime = time
  }
  
  func touchedTime(clockView: ClockView, time: ClockTime)  {
    clockView.handsView.clockTime = nil
  }
}
