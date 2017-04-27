import UIKit

class ViewController: UIViewController {
    var userDefault:NSUserDefaults = NSUserDefaults.standardUserDefaults() //建立物件
    
    @IBOutlet weak var textFieldName: UITextField!
    
    @IBAction func clearClick(sender: UIButton) {
        userDefault.removeObjectForKey("userName") //清除資料
        textFieldName.text = ""
        alertOneBtn("清除資料", pMessage: "姓名資料已清除！", btnTitle: "確定")
    }
    
    @IBAction func inputClick(sender: UIButton) {
        userDefault.setObject(textFieldName.text, forKey: "userName") //寫入資料
        userDefault.synchronize() //更新資料
        alertOneBtn("寫入資料", pMessage: "姓名資料已寫入！", btnTitle: "確定")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool){
        let name:String? = userDefault.objectForKey("userName")  as! String? //讀取資料
        if name == nil { //沒有資料
            alertOneBtn("輸入姓名", pMessage: "歡迎使用本應用程式！\n你尚未建立基本資料，請輸入姓名！", btnTitle: "確定")
        } else { //資料已存在
            let msg:String = "親愛的 " + name! + "，你好！\n歡迎再次使用本應用程式！"
            alertOneBtn("歡迎", pMessage: msg, btnTitle: "確定")
        }
        
    }

    func alertOneBtn(pTitle:String, pMessage:String, btnTitle:String) {
        let alertController = UIAlertController(title: pTitle, message: pMessage, preferredStyle: .Alert)
        let sureAction = UIAlertAction(title: btnTitle, style: .Default,handler:nil)
        alertController.addAction(sureAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

