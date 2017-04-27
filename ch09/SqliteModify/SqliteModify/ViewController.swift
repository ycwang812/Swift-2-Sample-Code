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
    
    var arrStu:Array<stu> = [] //存資料庫的陣列
    var db:COpaquePointer = nil
    var statement:COpaquePointer = nil
    var sql:NSString = "" //SQL指令
    var currentStu = 0 //目前資料
    
    @IBOutlet var labelId: UILabel! //顯示資料編號
    @IBOutlet var textName: UITextField! //輸入姓名
    @IBOutlet var textChinese: UITextField! //輸入國文成績
    @IBOutlet var textMath: UITextField! //輸入數學成績
    @IBOutlet var tableViewSqlite: UITableView!
    @IBOutlet var buttonInsert: UIButton!
    @IBOutlet var buttonWrite: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonToggle(true, writeAble:false)
        //第一次執行時將資料庫複製到 Documents 資料夾
        let fm:NSFileManager = NSFileManager()
        db = nil
        let src:String = NSBundle.mainBundle().pathForResource("student", ofType: "sqlite")!
        let dst:String = NSHomeDirectory() + "/Documents/student.sqlite"
        if !fm.fileExistsAtPath(dst) {
            do {
                try fm.copyItemAtPath(src, toPath: dst)
            } catch _ {
            }
        }
        //連結及開啟資料庫
        if sqlite3_open(dst, &db) != SQLITE_OK {
            alertMsg("失敗", msgStr:"無法開啟資料庫！")
            exit(1)
        }
        //讀取資料庫
        sql = "SELECT * FROM class101"
        statement = nil
        if sqlite3_prepare_v2(db, sql.UTF8String, -1, &statement, nil) != SQLITE_OK {
            alertMsg("失敗", msgStr:"讀取資料庫失敗！")
            exit(1)
        }
        //逐筆讀取資料列
        while sqlite3_step(statement) == SQLITE_ROW {
            let id = sqlite3_column_int(statement, 0)
            let temName = sqlite3_column_text(statement, 1)
            let name = String.fromCString(UnsafePointer<CChar>(temName))
            let chinese = sqlite3_column_int(statement, 2)
            let math = sqlite3_column_int(statement, 3)
            let student:stu = stu(id: id, name: name!, chinese: chinese, math: math)
            arrStu.append(student) //將資料列存入陣列
        }
        sqlite3_finalize(statement)
        tableViewSqlite.reloadData()
        showSingle(0) //開始時顯示第一筆資料
    }
    
    //更新資料
    @IBAction func modifyClick(sender: UIButton) {
        alertView("更新", msgStr:"確定要更新資料嗎?")
    }
    
    //刪除資料
    @IBAction func deleteClick(sender: UIButton) {
        if arrStu.count > 1 { //資料大於 1 筆才允許刪除
            alertView("刪除", msgStr:"確定要刪除資料嗎？")
        } else {
            self.alertMsg("失敗", msgStr:"只有一筆資料時不可刪除！")
        }
    }
    
    func alertView(buttonTitle: String, msgStr: String){
        let alertController = UIAlertController(title: buttonTitle, message: msgStr, preferredStyle: .Alert)
        if buttonTitle == "更新" {
            let sureAction = UIAlertAction(title: buttonTitle, style: .Default, handler: { action ->Void in
                //確定更新資料，更新資料庫
                let sqltem1:String = "UPDATE class101 SET s_name='" + self.textName.text! + "', s_chinese=" + self.textChinese.text!
                let sqltem2:String = ", s_math=" + self.textMath.text! + " WHERE s_id=" + self.labelId.text!
                self.sql = sqltem1 + sqltem2
                self.statement = nil
                sqlite3_prepare_v2(self.db, self.sql.UTF8String, -1, &self.statement, nil)
                if sqlite3_step(self.statement) == SQLITE_DONE {
                    self.alertMsg("成功", msgStr:"資料庫更新成功！")
                } else {
                    self.alertMsg("失敗", msgStr:"資料庫更新失敗！")
                }
                //更新陣列
                self.arrStu[self.currentStu].name = self.textName.text!
                self.arrStu[self.currentStu].chinese = Int32(Int(self.textChinese.text!)!)
                self.arrStu[self.currentStu].math = Int32(Int(self.textMath.text!)!)
                self.tableViewSqlite.reloadData()
            })
            alertController.addAction(sureAction)
        } else if buttonTitle == "刪除" {
            let sureAction = UIAlertAction(title: buttonTitle, style: .Default, handler: { action ->Void in
                //確定刪除資料，更新資料庫
                self.sql = "DELETE FROM class101 WHERE s_id=" + self.labelId.text!
                self.statement = nil
                sqlite3_prepare_v2(self.db, self.sql.UTF8String, -1, &self.statement, nil)
                if sqlite3_step(self.statement) == SQLITE_DONE {
                    self.alertMsg("成功", msgStr:"資料庫刪除成功！")
                } else {
                    self.alertMsg("失敗", msgStr:"資料庫刪除失敗！")
                }
                self.arrStu.removeAtIndex(self.currentStu)
                self.tableViewSqlite.reloadData()
                //資籵刪除後，顯示下一筆
                if self.currentStu == self.arrStu.count {
                    --self.currentStu
                }
                self.showSingle(self.currentStu)
            })
            alertController.addAction(sureAction)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .Default, handler:nil)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //按新增資料鈕
    @IBAction func insertClick(sender: UIButton) {
        buttonToggle(false, writeAble:true)
        labelId.text = ""
        textName.text = ""
        textChinese.text = ""
        textMath.text = ""
    }
    
    //將新增資料寫入資料庫
    @IBAction func writeClick(sender: UIButton) {
        buttonToggle(true, writeAble:false)
        sql =  "INSERT INTO class101 (s_name, s_chinese, s_math) VALUES ('\(textName.text!)', \(textChinese.text!), \(textMath.text!))"
        statement = nil
        sqlite3_prepare_v2(db, sql.UTF8String, -1, &statement, nil)
        if sqlite3_step(statement) == SQLITE_DONE {
            alertMsg("成功", msgStr:"資料庫新增成功！")
        } else {
            alertMsg("失敗", msgStr:"資料庫新增失敗！")
        }
        let id = Int32(sqlite3_last_insert_rowid(db))
        let name = textName.text
        let chinese = Int32(Int(textChinese.text!)!)
        let math = Int32(Int(textMath.text!)!)
        let student:stu = stu(id: id, name: name!, chinese: chinese, math: math)
        arrStu.append(student) //將資料列存入陣列
        tableViewSqlite.reloadData()
        showSingle(arrStu.count - 1)
        currentStu = arrStu.count - 1
    }
    
    //顯示單筆資料
    func showSingle(n:Int) {
        labelId.text = "\(arrStu[n].id)"
        textName.text = arrStu[n].name
        textChinese.text = "\(arrStu[n].chinese)"
        textMath.text = "\(arrStu[n].math)"
    }
    
    func buttonToggle(insertAble:Bool, writeAble:Bool) -> Void {
        buttonInsert.enabled = insertAble
        buttonWrite.enabled = writeAble
    }
    
    func alertMsg(titleStr:String, msgStr:String) -> Void {
        let alertController = UIAlertController(title: titleStr, message: msgStr, preferredStyle: .Alert)
        let sureAction = UIAlertAction(title: "確定", style: .Default,handler:nil)
        alertController.addAction(sureAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        return arrStu.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = tableView!.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = "姓名：\(arrStu[indexPath.row].name)"
        cell.detailTextLabel?.text = "國文：\(arrStu[indexPath.row].chinese)   數學：\(arrStu[indexPath.row].math)"
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        buttonToggle(true, writeAble:false)
        currentStu = indexPath.row
        showSingle(currentStu)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

