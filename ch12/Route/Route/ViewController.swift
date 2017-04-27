import UIKit
import MapKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //取得現在位置
        let currentLocation = MKMapItem.mapItemForCurrentLocation()
        // 建立台北101地標
        let markTaipei = MKPlacemark(coordinate: CLLocationCoordinate2DMake(25.0305, 121.5651), addressDictionary: nil)
        // 在終點顯示地標
        let taipei101 = MKMapItem(placemark: markTaipei)
        taipei101.name = "台北101"
        //以現在位置為起點，台北101為終點
        let array = NSArray(objects: currentLocation, taipei101)
        //設定導航模式為汽車導航
        let parameter = NSDictionary(object: MKLaunchOptionsDirectionsModeDriving, forKey: MKLaunchOptionsDirectionsModeKey)
        // 開啟內建地圖
        MKMapItem.openMapsWithItems(array as! [MKMapItem], launchOptions: parameter as? [String : AnyObject])
    }    
}