 import UIKit
 import CoreLocation
 class ViewController: UIViewController,CLLocationManagerDelegate{
    var locationManager : CLLocationManager!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var labelHeading: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 建立 CLLocationManager 管理類別物件
        locationManager = CLLocationManager()
        // 設定委派
        locationManager.delegate = self
        // 設定精度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 取得App定位服務授權
        locationManager.requestAlwaysAuthorization()
        // 開啟更新方位角
        locationManager.startUpdatingHeading()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading){
        if newHeading.headingAccuracy < 0 {
            print("請進行校正!")
            return
        }
        labelHeading.text = "目前方位角 = \(newHeading.magneticHeading)"
        // 調整(旋轉)圖片的角度
        let angle:CGFloat = CGFloat((newHeading.magneticHeading) / 180.0 * M_PI)
        img.transform = CGAffineTransformMakeRotation(-angle)
    }
    
    override func viewDidDisappear(animated: Bool){
        // 停止取得方位角
        locationManager.stopUpdatingHeading()
    }
    
    // 錯誤理處
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError){
        let mess = error.description
        // 建立警示對話方塊
        let alertController = UIAlertController(title: "確認視窗", message: mess, preferredStyle: .Alert)
        // 建立按鈕
        let sureAction = UIAlertAction(title: "確定", style: .Default,handler:nil)
        // 按鈕加入對話方塊
        alertController.addAction(sureAction)
        // 顯示對話方塊
        self.presentViewController(alertController, animated: true, completion: nil)

    }
 }
 
 
