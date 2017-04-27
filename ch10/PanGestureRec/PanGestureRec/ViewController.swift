import UIKit

class ViewController: UIViewController {

    @IBAction func panProcess(sender: UIPanGestureRecognizer) {
        for var i=0; i < sender.numberOfTouches() ; i++ {
            let point:CGPoint = sender.locationOfTouch(i, inView: sender.view)
            print("第 \(i+1) 手指位置：\(NSStringFromCGPoint(point))")
        }
    }

}