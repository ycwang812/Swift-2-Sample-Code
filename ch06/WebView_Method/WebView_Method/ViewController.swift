import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        // 1. loadData 載入網頁，需要權限
//        let url=NSURL(string: "http://www.e-happy.com.tw")
//        let request=NSURLRequest(URL: url!)
//        webView!.loadRequest(request)

        // 2. 載入地圖，需要權限
//          let address:NSString = "http://maps.google.com/maps?h1=zh-TW&q=" + "台北 101"
//          let url:NSURL = NSURL(string: address.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)!
//          let request=NSURLRequest(URL: url)
//          webView!.loadRequest(request)
//        
        // 3. loadHTMLString 載入網頁內容，不需要權限
        //let content = "<html><body><h1>Hello!</h1><body></html>"
        //webView!.loadHTMLString(content, baseURL: nil)
        
        //4. loadData，不需要權限
//        let filePath = NSBundle.mainBundle().pathForResource("img01", ofType: "jpg")
//        let file = NSData(contentsOfFile: filePath!)
//        webView!.loadData(file!, MIMEType: "image/jpg", textEncodingName: "", baseURL: NSURL())
        
        //5. loadData -- index.html，不需要權限
        let filePath = NSBundle.mainBundle().pathForResource("index", ofType: "html")
        let file = NSData(contentsOfFile: filePath!)
        webView!.loadData(file!, MIMEType: "text/html", textEncodingName: "UTF-8", baseURL: NSURL())
        
        
    }

}

