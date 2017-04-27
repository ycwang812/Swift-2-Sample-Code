import MapKit

class myAnnotation: NSObject, MKAnnotation {
    var coordinate:CLLocationCoordinate2D
    var title:String? = ""
    var subtitle:String? = ""
    var image:UIImage = UIImage()
    
    init(coordinate:CLLocationCoordinate2D,title:String,subtitle:String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}