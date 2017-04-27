import UIKit

class ViewController: UIViewController {

    @IBAction func longPress(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Began{
            // 建立警示對話方塊
            let alertController = UIAlertController(title: "確認視窗", message: "確定要結束應用程式嗎？", preferredStyle: .Alert)
            // 建立按鈕
            let cancelAction = UIAlertAction(title: "是", style: .Cancel,handler:
                {action->Void in
                    print("您按下 \(action.title!) 按鈕!")
            });
            let sureAction = UIAlertAction(title: "否", style: .Default,handler:{action->Void in
                print("您按下 \(action.title!) 按鈕!")
            });
            // 按鈕加入對話方塊
            alertController.addAction(cancelAction)
            alertController.addAction(sureAction)
            // 顯示對話方塊
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }

}