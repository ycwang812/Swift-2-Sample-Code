 import UIKit
 import CoreLocation
 class ViewController: UIViewController,CLLocationManagerDelegate{
    var locationManager : CLLocationManager!
    @IBOutlet weak var labelLat: UILabel!
    @IBOutlet weak var labelLng: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 建立CLLocationManager管理類別物件
        locationManager = CLLocationManager()
        // 設定委派
        locationManager.delegate = self
        // 設定精確度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 取得App定位服務授權
        locationManager.requestAlwaysAuthorization()
        // 開啟更新位置
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let curLocation:CLLocation = locations[0]
        let lat = curLocation.coordinate.latitude
        let lng = curLocation.coordinate.longitude
        print("緯度= \(lat) 經度= \(lng)")
        labelLat.text = "緯度= \(lat)"
        labelLng.text = "經度= \(lng)"
    }
    
    override func viewDidDisappear(animated: Bool){
        // 停止取得定位點
        locationManager.stopUpdatingLocation()
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