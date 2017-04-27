import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate{
    var locationManager : CLLocationManager!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func longPress(sender: UILongPressGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.Began{
            // 建立對話方塊
            let alertController = UIAlertController(title: "地圖模式", message: "請選擇顯示的地圖模式", preferredStyle: .Alert)
            // 建立按鈕
            let StandardAction = UIAlertAction(title: "一般地圖", style: .Default,handler:
                {action->Void in
                    self.mapView.mapType = .Standard
            });
            let SateliteAction = UIAlertAction(title: "衛星地圖", style: .Default,handler:{action->Void in
                self.mapView.mapType = .Satellite
            });
            let HyBridAction = UIAlertAction(title: "混合地圖", style: .Default,handler:{action->Void in
                self.mapView.mapType = .Hybrid
            });
            // 按鈕加入對話方塊
            alertController.addAction(StandardAction)
            alertController.addAction(SateliteAction)
            alertController.addAction(HyBridAction)
            // 顯示對話方塊
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 允許縮放
        mapView.zoomEnabled = true
        // 不顯示定位圖示
        mapView.showsUserLocation = false
        // 建立 CLLocationManager 管理類別物件
        locationManager = CLLocationManager()
        // 設定代理
        locationManager.delegate = self
        // 設定精度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 取得App定位服務授權
        locationManager.requestAlwaysAuthorization()
        // 開啟更新位置
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let curLocation:CLLocation = locations[0]
        // 以現在位置為中心點
        let location = CLLocationCoordinate2D(
            latitude: curLocation.coordinate.latitude,
            longitude: curLocation.coordinate.longitude
        )
        let span = MKCoordinateSpanMake(0.02, 0.02)  // 縮放比例
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        // 加上地標
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "現在位置"
        annotation.subtitle = "\(location.latitude),\(location.longitude)"
        mapView.addAnnotation(annotation)
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