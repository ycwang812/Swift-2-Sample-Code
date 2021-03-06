import UIKit

class ViewController: UIViewController {
    var dateFormatter = NSDateFormatter() //宣告日期時間格式變數
    
    @IBOutlet weak var datePicker: UIDatePicker! //DatePicker元件連結
    @IBOutlet weak var labelMsg: UILabel! //顯示訊息連結
    
    //使用者選取日期時間就更新顯示
    @IBAction func dateChange(sender: UIDatePicker) {
        labelMsg.text = dateFormatter.stringFromDate(datePicker.date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.datePickerMode = UIDatePickerMode.DateAndTime //顯示模式
        datePicker.locale = NSLocale(localeIdentifier: "zh_TW") //繁體中文
        datePicker.date = NSDate() //開始時為現在日期及時間
        dateFormatter.dateFormat = "西元y年M月d日 hh點mm分ss秒" //顯示格式
        labelMsg.text = dateFormatter.stringFromDate(datePicker.date)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

