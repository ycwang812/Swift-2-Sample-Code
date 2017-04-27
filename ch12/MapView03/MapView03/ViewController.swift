import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate{
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func button1Click(sender: UIButton) {
        // 地標一
        let location = CLLocationCoordinate2D(
            latitude: 25.0335,
            longitude: 121.5651
        )
        let annotation = myAnnotation(coordinate:location,title:"現在位置",subtitle:"地標一")
        annotation.image = UIImage(named:"onebit_01")!
        mapView.addAnnotation(annotation)
    }
    
    @IBAction func button2Click(sender: UIButton) {
        let location = CLLocationCoordinate2D(
            latitude: 25.0335,
            longitude: 121.2051
        )
        // 設定中心點
        let span = MKCoordinateSpanMake(0.05, 0.05)  // 縮放比例
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        // 地標二
        let annotation = myAnnotation(coordinate:location,title:"現在位置",subtitle:"地標二")
        annotation.image = UIImage(named:"onebit_02")!
        mapView.addAnnotation(annotation)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 設定委派
        mapView.delegate = self
        // 以台北101為中心點
        let location = CLLocationCoordinate2D(
            latitude: 25.0335,
            longitude: 121.5651
        )
        let span = MKCoordinateSpanMake(0.05, 0.05)  // 縮放比例
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?{
        // 如果不是自建地標，將不予處理
        if !(annotation is myAnnotation) {
            return nil
        }
        // 判斷該地標是否已經建立
        let reuseId = "test"
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        // 如果地標已經建立，直接顯示該地標，否則就建立一個可自訂圖示的新地標
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView!.canShowCallout = true // 顯示地標對話方塊
        }else{
            anView!.annotation = annotation
        }
        // 強制轉換為 myAnnotation 型別，取得地標圖示
        let myAno = annotation as! myAnnotation
        anView!.image = myAno.image
        return anView
    }
    
}