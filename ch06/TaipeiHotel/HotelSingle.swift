import Foundation

//該筆旅館資料類別
class HotelSingle {
    var name:NSString!
    var tel:NSString!
    var display_addr:NSString!
    var poi_addr:NSString!
    
    init(dict:AnyObject) {
        self.name = dict["name"] as! NSString
        self.tel = dict["tel"] as! NSString
        self.display_addr = dict["display_addr"] as! NSString
        self.poi_addr = dict["poi_addr"] as! NSString
    }
}
