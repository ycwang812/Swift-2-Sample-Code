import UIKit

class myTableViewController: UITableViewController,mydelegate { // 繼承協議
    var eHttp:HttpController = HttpController() //AJAX讀取網頁
    var allData:Array<HotelSingle> = [] //存所有資料
    var selectedHotel:Int = 0 //使用者選取的旅館
    
    // 實作 ReceiveResults 方法
    func ReceiveResults(results:NSArray) {
        //建立所有資料陣列
        for dict:AnyObject in results { //results 是 JSON 資料
            let hotelSingle = HotelSingle(dict: dict as! NSDictionary)
            allData.append(hotelSingle)
        }
        self.tableView.reloadData() //重新顯示資料
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //設定 HttpController 委派 myTableViewController 執行
        eHttp.delegate = self
        eHttp.onSearch("http://data.taipei.gov.tw/opendata/apply/json/QTdBNEQ5NkQtQkM3MS00QUI2LUJENTctODI0QTM5MkIwMUZE") //讀取JSON資料
    }
    
    //分區資料筆數
    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        return allData.count
    }
    
    //顯示分區名稱及旅館數
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = String(allData[indexPath.row].name)
        cell.detailTextLabel?.text = String(allData[indexPath.row].tel) + " " + String(allData[indexPath.row].display_addr)
        return cell
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath {
        selectedHotel = indexPath.row
        return indexPath
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        let destViewController:ViewController = segue!.destinationViewController as! ViewController
        let hotelSingle = allData[selectedHotel]
        destViewController.hotelName = hotelSingle.name as String //傳送旅館名稱
        destViewController.hotelAddr = hotelSingle.display_addr //傳送旅館地址
    }
    
}