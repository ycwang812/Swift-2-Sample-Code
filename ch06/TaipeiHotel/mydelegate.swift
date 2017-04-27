import Foundation

// 建立協議
protocol mydelegate {
    // 定義方法，以results傳送讀取的資料
    func ReceiveResults(results:NSArray)
}