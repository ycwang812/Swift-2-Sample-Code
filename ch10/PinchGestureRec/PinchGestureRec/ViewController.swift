import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var img: UIImageView!
    @IBAction func pinchProcess(sender: UIPinchGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Began{
            // 開始縮放
        } else if sender.state == UIGestureRecognizerState.Changed{
            // 將圖片放大或縮小
            let frame=img.frame // 取得圖片框
            let s=sender.scale  // 縮放比例
            let w=img.frame.width  // 目前圖片寬度
            let h=img.frame.height // 目前圖片高度
            print("scale=\(s)")
            if s*w > 100 && s*w < 400 {
                // 重設圖片框
                img.frame=CGRectMake(frame.origin.x, frame.origin.y, s*w, s*h)
            }
        } else if sender.state == UIGestureRecognizerState.Ended{
            // 結束縮放
        }
    }

}