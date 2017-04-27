import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var buttonShowAlert: UIView!
    @IBOutlet weak var labelResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 設定圓角按鈕
        buttonShowAlert.layer.cornerRadius = 10 //圓角角度
    }
    
    @IBAction func alert1Click(sender: UIButton) {
        // 建立警示對話方塊
        let alertController = UIAlertController(title: "確認視窗", message: "確定要結束應用程式嗎？", preferredStyle: .Alert)
        // 建立按鈕
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel,handler:
            {action->Void in
            self.labelResult.text = "您按下 \(action.title!) 按鈕!"
        });
        let sureAction = UIAlertAction(title: "確定", style: .Default,handler:{action->Void in
            self.labelResult.text = "您按下 \(action.title!) 按鈕!"
        });
        // 按鈕加入對話方塊
        alertController.addAction(cancelAction)
        alertController.addAction(sureAction)
        // 顯示對話方塊
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}

