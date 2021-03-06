import UIKit

class ViewController: UIViewController {
    var hotelName:String = ""   //接收的旅館名稱
    var hotelAddr:NSString = "" //接收的旅館地址
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var labelName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelName.text = hotelName //顯示旅館名稱
        //依地址在瀏覽器顯示地圖(載入地圖，需要設定權限)
        let address:NSString = "http://maps.google.com/maps?hl=zh-TW&q=" + (hotelAddr as String)
        let url:NSURL = NSURL(string: address.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)!
        let request=NSURLRequest(URL: url)
        webView!.loadRequest(request)
    }
}