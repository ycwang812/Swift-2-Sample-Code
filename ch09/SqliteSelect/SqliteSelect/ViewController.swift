import UIKit

class ViewController: UIViewController {
    //資料庫結構：主索引 姓名 國文成績 數學成績
    struct stu {
        var id:Int32
        var name:String
        var chinese:Int32
        var math:Int32
        init(id:Int32, name:String, chinese:Int32, math:Int32) {
            self.id = id
            self.name = name
            self.chinese = chinese
            self.math = math
        }
    }
    
    var db:COpaquePointer = nil; //資料庫
    var statement:COpaquePointer = nil //資料記錄
    var arrStu:Array<stu> = [] //存資料的陣列
    @IBOutlet var textFieldId: UITextField!
    @IBOutlet var tableViewSqlite: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //連結及開啟資料庫
        let src:String = NSBundle.mainBundle().pathForResource("student", ofType: "sqlite")!
        if sqlite3_open(src, &db) != SQLITE_OK {
            alertOneBtn("開啟失敗", pMessage:"無法開啟資料庫！", btnTitle:"確定")
            exit(1)
        }
    }
    
    @IBAction func searchClick(sender: UIButton) {
        if textFieldId.text == "" {
            alertOneBtn("輸入確認", pMessage:"必須輸入編號！", btnTitle:"確定")
        } else {
            let n:Int? = Int(textFieldId.text!)!
            if n<1 || n>6 { //輸入編號超過範圍
                alertOneBtn("範圍確認", pMessage:"輸入的編號超過範圍 (1－6)！", btnTitle:"確定")
            } else {
                //根據編號讀取資料
                let sql:NSString = "SELECT * FROM class101 WHERE s_id=" + textFieldId.text!
                statement = nil
                if sqlite3_prepare_v2(db, sql.UTF8String, -1, &statement, nil) != SQLITE_OK {
                    alertOneBtn("讀取失敗", pMessage:"讀取資料庫失敗！", btnTitle:"確定")
                    exit(1)
                }
                arrStu.removeAll(keepCapacity: true)
                if sqlite3_step(statement) == SQLITE_ROW { //資料只有一筆
                    addItem()
                    sqlite3_finalize(statement) //關閉資料記錄
                    tableViewSqlite.reloadData() //更新顯示
                }
            }
        }
    }
    
    @IBAction func searchAllClick(sender: UIButton) {
        //讀取全部資料庫
        let sql:NSString = "SELECT * FROM class101"
        statement = nil
        if sqlite3_prepare_v2(db, sql.UTF8String, -1, &statement, nil) != SQLITE_OK {
            alertOneBtn("讀取失敗", pMessage:"讀取資料庫失敗！", btnTitle:"確定")
            exit(1)
        }
        arrStu.removeAll(keepCapacity: true)
        //逐筆讀取資料列
        while sqlite3_step(statement) == SQLITE_ROW {
            addItem()
        }
        sqlite3_finalize(statement)
        tableViewSqlite.reloadData()
    }
    
    func addItem() -> Void {
        let id = sqlite3_column_int(statement, 0)
        let temName = sqlite3_column_text(statement, 1)
        let name = String.fromCString(UnsafePointer<CChar>(temName))
        let chinese = sqlite3_column_int(statement, 2)
        let math = sqlite3_column_int(statement, 3)
        let student:stu = stu(id: id, name: name!, chinese: chinese, math: math)
        arrStu.append(student) //將資料列存入陣列
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        return arrStu.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = tableView!.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = "姓名：\(arrStu[indexPath.row].name)"
        cell.detailTextLabel?.text = "編號：\(arrStu[indexPath.row].id)   國文：\(arrStu[indexPath.row].chinese)   數學：\(arrStu[indexPath.row].math)"
        return cell
    }

    func alertOneBtn(pTitle:String, pMessage:String, btnTitle:String) {
        let alertController = UIAlertController(title: pTitle, message: pMessage, preferredStyle: .Alert)
        let sureAction = UIAlertAction(title: btnTitle, style: .Default,handler:nil)
        alertController.addAction(sureAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

