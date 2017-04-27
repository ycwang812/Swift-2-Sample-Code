import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textURL: UITextField!
    @IBOutlet var webView:UIWebView?
    
    @IBAction func buttonClick(sender: UIButton) {
        var str=textURL.text
        if !str!.hasPrefix("http://"){
            str="http://" + str!
        }
        // 載入網頁
        let url=NSURL(string: str!)
        let request=NSURLRequest(URL: url!)
        webView!.loadRequest(request)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 載入網頁
        let url=NSURL(string: "http://www.e-happy.com.tw")
        let request=NSURLRequest(URL: url!)
        webView!.loadRequest(request)
    }
    
    @IBAction func stop(sender: UIBarButtonItem) {
        webView!.stopLoading()
    }
    
    @IBAction func doRefresh(sender: UIBarButtonItem) {
        webView!.reload()
    }
    
    @IBAction func goBack(sender: UIBarButtonItem) {
        webView!.goBack()
    }
    
    @IBAction func goForward(sender: UIBarButtonItem) {
        webView!.goForward()
    }
}