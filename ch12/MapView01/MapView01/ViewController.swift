import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate{
    var locationManager : CLLocationManager!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 顯示定位圖示
        mapView.showsUserLocation = true
        // 允許縮放
        mapView.zoomEnabled = true
        // 建立 CLLocationManager 管理類別物件
        locationManager = CLLocationManager()
        // 設定委派
        locationManager.delegate = self
        // 設定精度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 取得App定位服務授權
        locationManager.requestAlwaysAuthorization()
        // 開啟更新位置
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 取得現在位置
        let curLocation:CLLocation = locations[0]
        // 以現在位置為中心點
        let location = CLLocationCoordinate2D(
            latitude: curLocation.coordinate.latitude,
            longitude: curLocation.coordinate.longitude
        )
        // 設定地圖顯示區域、中心點和縮放比例
        let span = MKCoordinateSpanMake(0.05, 0.05)  // 縮放比例
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
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