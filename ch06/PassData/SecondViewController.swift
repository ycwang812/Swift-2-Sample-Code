import UIKit

class SecondViewController: UIViewController {
    // 建立委派物件
    var delegate:mydelegate? = nil
    var data:String?  // 建立屬性
    @IBOutlet weak var text2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 取得第一頁傳遞的資料
        self.text2.text=data
    }
    
    @IBAction func buttonClick(sender: UIButton) {
        // 按下 返回第一頁 鈕時執行委派
        if (delegate != nil) {
            delegate!.myfunc(self,text:self.text2.text!)
        }
        // 結束頁面
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}