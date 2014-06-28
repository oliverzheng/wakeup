import UIKit

class MainViewController: UIViewController {
  
  @IBOutlet var clockContainerView: UIView

  override func viewDidLoad() {
    super.viewDidLoad()

    var clockFrame = self.clockContainerView.frame
    clockFrame.origin = CGPoint(x: 0, y: 0)
    clockContainerView.addSubview(ClockView(frame: clockFrame))
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
