import UIKit

class ViewController: UIViewController,mydelegate {
    @IBOutlet weak var text1: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 實作委派取得第二頁傳遞的資料 text
    func myfunc(controller:SecondViewController,text:String){
        self.text1.text=text
    }
    
    // 頁面切換
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)  {
        // 比對是否按下 mySegue
        if segue.identifier == "mySegue"{
            let vc=segue.destinationViewController as! SecondViewController
            vc.data = self.text1.text
            vc.delegate = self // 委派 ViewController 執行
        }
    }
}
