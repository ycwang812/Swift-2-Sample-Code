import UIKit

class ViewController: UIViewController {
    var fm:NSFileManager = NSFileManager() //建立檔案管理物件
    var fileName:String = NSHomeDirectory() + "/Documents/" + "password.txt" //密碼檔路徑
    var readContent:NSString = "" //檔案內容
    
    @IBOutlet var textFieldID: UITextField!
    @IBOutlet var textFieldPW: UITextField!
    @IBOutlet var labelContent: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //如果密碼檔已存在，就讀出並顯示
        if fm.fileExistsAtPath(fileName) {
            readContent = try! NSString(contentsOfFile: fileName, encoding: NSUTF8StringEncoding)
            labelContent.text = readContent as String
        }
    }
    
    //按 加入資料 鈕
    @IBAction func insertClick(sender: UIButton) {
        if textFieldID.text == "" || textFieldPW.text == "" {
            alertOneBtn("輸入確認", pMessage:"帳號及密碼都要輸入！", btnTitle:"確定")
        } else { //帳號及密碼皆已輸入
            if !fm.fileExistsAtPath(fileName) { //如果密碼檔不存在就新建
                fm.createFileAtPath(fileName, contents: nil, attributes: nil)
            }
            readContent = (readContent as String) + textFieldID.text! + "\n" + textFieldPW.text! + "\n" //加入輸入的帳號密碼
            var flag: Bool
            do {
                try readContent.writeToFile(fileName, atomically: true, encoding: NSUTF8StringEncoding)
                flag = true
            } catch _ {
                flag = false
            } //寫入檔案
            if flag { //存檔成功
                alertOneBtn("存檔", pMessage:"資料寫入成功！", btnTitle:"確定")
                labelContent.text = readContent as String
            } else { //存檔失敗
                alertOneBtn("失敗", pMessage:"資料寫入失敗！", btnTitle:"確定")
            }
        }
    }
    
    @IBAction func clearClick(sender: UIButton) {
        readContent = "" //清除所有資料
        var flag: Bool
        do {
            try readContent.writeToFile(fileName, atomically: true, encoding: NSUTF8StringEncoding)
            flag = true
        } catch _ {
            flag = false
        } //將空資料寫入檔案
        if flag { //存檔成功
            labelContent.text = readContent as String
            textFieldID.text = ""
            textFieldPW.text = ""
            alertOneBtn("清除資料", pMessage:"資料已完全清除！", btnTitle:"確定")
        } else { //存檔失敗
            alertOneBtn("失敗", pMessage:"資料清除失敗！", btnTitle:"確定")
        }
        labelContent.text = ""
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

