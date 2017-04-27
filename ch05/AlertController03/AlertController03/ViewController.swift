import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var labelResult: UILabel!
    @IBOutlet weak var buttonLogin: UIButton!
    let UserName:String = "David" // 帳號
    let Password:String = "1234"  // 密碼
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 設定圓角按鈕
        buttonLogin.layer.cornerRadius = 10 //圓角角度
    }
    
    @IBAction func alertClick(sender: UIButton) {
        // 建⽴ alertController
        let alertController = UIAlertController(title: "系統登入", message: "歡迎光臨!", preferredStyle: UIAlertControllerStyle.Alert)
        
        // 建⽴登入按鈕
        let loginAction = UIAlertAction(title: "登入", style: .Default, handler: { action ->Void in
            // 取得文字方塊內容
            let textUserName = alertController.textFields![0] 
            let textPassword = alertController.textFields![1]
            // 比對帳號、密碼
            if (self.UserName == textUserName.text && self.Password == textPassword.text){
                self.labelResult.text=("歡迎光臨： \(textUserName.text!)")
            }else{
                self.labelResult.text=("帳號、密碼錯誤!")
            }
        })
        alertController.addAction(loginAction)
        
        // 建⽴取消按鈕
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // 建⽴第一個文字方塊
        alertController.addTextFieldWithConfigurationHandler {
            textField in
            textField.placeholder = "Login"
        }
        
        // 建⽴第二個文字方塊
        alertController.addTextFieldWithConfigurationHandler {
            textField in
            textField.placeholder = "Password"
            textField.secureTextEntry = true
        }
        
        // 顯⽰對話方塊
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}