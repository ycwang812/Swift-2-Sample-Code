import UIKit

class ViewController: UIViewController {
    @IBAction func alert1Click(sender: UIButton) {
        // 建立警示對話方塊
        let alertController = UIAlertController(title: "確認視窗", message: "確定要結束應用程式嗎？", preferredStyle: .Alert)
        // 建立按鈕
        let calcelAction = UIAlertAction(title: "取消", style: .Cancel,handler:nil)
        let sureAction = UIAlertAction(title: "確定", style: .Default,handler:nil)
        // 按鈕加入對話方塊
        alertController.addAction(calcelAction)
        alertController.addAction(sureAction)
        // 顯示對話方塊
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func alert2Click(sender: UIButton) {
        // 建立提示對話方塊
        let alertController = UIAlertController(title: "確認視窗", message: "確定要結束應用程式嗎？", preferredStyle: .ActionSheet)
        // 建立按鈕
        let calcelAction = UIAlertAction(title: "取消", style: .Cancel,handler:nil)
        let sureAction = UIAlertAction(title: "確定", style: .Default,handler:nil)
        // 按鈕加入對話方塊
        alertController.addAction(calcelAction)
        alertController.addAction(sureAction)
        // 顯示對話方塊
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}