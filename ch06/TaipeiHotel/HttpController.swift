import Foundation

class HttpController:NSObject {
    // 建立委派物件
    var delegate:mydelegate?=nil
    
    // AJAX讀取網頁資料類別
    func onSearch(urla:String) {
        let url:NSURL = NSURL(string: "http://data.taipei.gov.tw/opendata/apply/json/QTdBNEQ5NkQtQkM3MS00QUI2LUJENTctODI0QTM5MkIwMUZE")!
        let request = NSMutableURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        request.HTTPMethod = "GET"
        // 讀取網頁資料
        let task = session.dataTaskWithRequest(request,
            completionHandler: {data, response, error -> Void in
                // 將 response(NSURLResponse 型別) 轉換為 NSHTTPURLResponse 型別
                let httpResponse = response as? NSHTTPURLResponse
                // 讀取成功
                if httpResponse?.statusCode == 200 {
                    // 將 NSdata 轉換為 NSArray 型別
                    let array: NSArray = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSArray
                    // 成功讀取網頁資料後執行委派
                    self.delegate?.ReceiveResults(array)
                }
            } // Closure 定義結束
        )
        task.resume()
    }
}


