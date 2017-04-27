
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textURL: UITextField!
    @IBOutlet var webView:UIWebView?
    
    @IBAction func buttonClick(sender: UIButton) {
        var str=textURL.text
        if !str!.hasPrefix("http://"){
            str="http://" + str!
        }

     //   let HTML = "<!doctype html><html><body><div style=\"width: 100%%; text-align: center; font-size: 24pt;\">網頁內容</div></body></html>"
     //   webView!.loadHTMLString(HTML, baseURL: nil)
        
        //
 //       webView!.loadData(<#data: NSData!#>, MIMEType: <#String!#>, textEncodingName: <#String!#>, <#data: NSData!#>baseURL: <#NSURL!#>)
        
 //       var filePath = NSBundle.mainBundle().pathForResource("100", ofType: "jpg")
 //       var gif = NSData(contentsOfFile: filePath!)
 //       webView!.loadData(gif, MIMEType: "image/jpg", textEncodingName: nil, baseURL: nil)

        let filePath = NSBundle.mainBundle().pathForResource("bookmark", ofType: "htm")
        let gif = NSData(contentsOfFile: filePath!)
        webView!.loadData(gif!, MIMEType: "text/html", textEncodingName: "", baseURL: NSURL())
        //依地址在瀏覽器顯示地圖
//        var address:NSString = "http://maps.google.com/maps?hl=zh-TW&q=" + "台北 101"
//        var url:NSURL = NSURL(string: address.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)!
//        var request:NSURLRequest=NSURLRequest(URL: url)
//        self.webView!.loadRequest(request)
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // 載入網頁
     //   var url=NSURL(string: "http://google.com.tw")
     //   var request=NSURLRequest(URL: url!)
     //   webView!.loadRequest(request)
    }

}

