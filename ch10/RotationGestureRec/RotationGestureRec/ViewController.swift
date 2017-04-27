import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var img: UIImageView!
    
    @IBAction func rotateProcess(sender: UIRotationGestureRecognizer) {
        // 取得弧度
        let rad:CGFloat = sender.rotation
        // 計算角度
        let angle:Double = Double(rad) * 180 / M_PI
        // 圖片旋轉
        img.transform = CGAffineTransformMakeRotation(rad)
        print("旋轉角度=\(angle)")
    }

}