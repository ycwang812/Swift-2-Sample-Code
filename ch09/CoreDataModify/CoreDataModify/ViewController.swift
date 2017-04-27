import UIKit
import CoreData

class ViewController: UIViewController {
    var result:Array<Student> = [] //存資料庫的陣列
    var currentStu = 0 //第幾筆資料
    
    @IBOutlet var textName: UITextField! //輸入姓名
    @IBOutlet var textChinese: UITextField! //輸入國文成績
    @IBOutlet var textMath: UITextField! //輸入數學成績
    @IBOutlet var buttonInsert: UIButton!
    @IBOutlet var buttonWrite: UIButton!
    @IBOutlet var tableViewCore: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDele:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDele.managedObjectContext
        let fetch:NSFetchRequest = NSFetchRequest(entityName: "Student")
        do {
            try result = context.executeFetchRequest(fetch) as! Array<Student>
        } catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }
        initData()
        tableViewCore.reloadData()
        showSingle(0) //開始時顯示第一筆資料
        textName.enabled = false //讓姓名欄位不可輸入
    }
    
    //更新資料
    @IBAction func modifyClick(sender: UIButton) {
        //建立確認對話方塊
        alertView("更新", msgStr:"確定要更新資料嗎?")
    }
    
    //刪除資料
    @IBAction func deleteClick(sender: UIButton) {
        if result.count > 1 { //資料大於 1 筆才允許刪除
            alertView("刪除", msgStr:"確定要刪除資料嗎？")
        } else {
            print("只有一筆資料時不可刪除！")
        }
    }
    
    func alertView(buttonTitle: String, msgStr: String){
        let alertController = UIAlertController(title: buttonTitle, message: msgStr, preferredStyle: .Alert)
        if buttonTitle == "更新" {
            let sureAction = UIAlertAction(title: buttonTitle, style: .Default, handler: { action ->Void in
                //確定更新資料，更新資料庫
                let appDele:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let context:NSManagedObjectContext = appDele.managedObjectContext
                let fetch:NSFetchRequest = NSFetchRequest(entityName: "Student")
                var student:Array<Student> = []
                fetch.predicate = NSPredicate(format: "name = %@", self.result[self.currentStu].name!)
                do {
                    try student = context.executeFetchRequest(fetch) as! Array<Student>
                } catch let error as NSError {
                    print("Fetch failed: \(error.localizedDescription)")
                }
                student[0].chinese = Int(self.textChinese.text!)!
                student[0].math = Int(self.textMath.text!)!
                do {
                    try appDele.managedObjectContext.save()
                } catch _ {
                }
                //重新載入資料
                fetch.predicate = nil
                do {
                    try self.result = context.executeFetchRequest(fetch) as! [Student]
                } catch let error as NSError {
                    print("Fetch failed: \(error.localizedDescription)")
                }
                self.tableViewCore.reloadData()
            })
            alertController.addAction(sureAction)
        } else if buttonTitle == "刪除" {
            let sureAction = UIAlertAction(title: buttonTitle, style: .Default, handler: { action ->Void in
                //確定刪除資料，更新資料庫
                let appDele:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let context:NSManagedObjectContext = appDele.managedObjectContext
                let fetch:NSFetchRequest = NSFetchRequest(entityName: "Student")
                var student:Array<Student> = []
                fetch.predicate = NSPredicate(format: "name = %@", self.result[self.currentStu].name!)
                do {
                    try student = context.executeFetchRequest(fetch) as! Array<Student>
                } catch let error as NSError {
                    print("Fetch failed: \(error.localizedDescription)")
                }
                appDele.managedObjectContext.deleteObject(student[0])
                do {
                    try appDele.managedObjectContext.save()
                } catch _ {
                }
                //重新載入資料
                fetch.predicate = nil
                do {
                    try self.result = context.executeFetchRequest(fetch) as! [Student]
                } catch let error as NSError {
                    print("Fetch failed: \(error.localizedDescription)")
                }
                self.tableViewCore.reloadData()
                //資籵刪除後，顯示下一筆
                if self.currentStu == self.result.count {
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
        buttonInsert.enabled = false
        buttonWrite.enabled = true
        textName.enabled = true //讓姓名欄位可輸入
        textName.text = ""
        textChinese.text = ""
        textMath.text = ""
    }
    
    //將新增資料寫入資料庫
    @IBAction func writeClick(sender: UIButton) {
        buttonInsert.enabled = true
        buttonWrite.enabled = false
        textName.enabled = false //讓姓名欄位不可輸入
        let appDele:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDele.managedObjectContext
        let fetch:NSFetchRequest = NSFetchRequest(entityName: "Student")
        var student:Student
        student = NSEntityDescription.insertNewObjectForEntityForName("Student", inManagedObjectContext: appDele.managedObjectContext) as! Student
        student.name = textName.text!
        student.chinese = Int(self.textChinese.text!)!
        student.math = Int(self.textMath.text!)!
        do {
            try appDele.managedObjectContext.save()
        } catch _ {
        }
        do {
            try result = context.executeFetchRequest(fetch) as! Array<Student>
        } catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }
        tableViewCore.reloadData()
        currentStu = result.count - 1
    }
    
    //顯示單筆資料
    func showSingle(n:Int) {
        textName.text = result[n].name
        textChinese.text = "\(result[n].chinese!)"
        textMath.text = "\(result[n].math!)"
    }
    
    //第一次執行時新增 5 資料
    func initData() {
        if result.count == 0 {
            let appDele:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let context:NSManagedObjectContext = appDele.managedObjectContext
            let fetch:NSFetchRequest = NSFetchRequest(entityName: "Student")
            var student:Student
            student = NSEntityDescription.insertNewObjectForEntityForName("Student", inManagedObjectContext: context) as! Student
            student.name = "林大山"
            student.chinese = 93
            student.math = 98
            do {
                try context.save()
            } catch _ {
            }
            student = NSEntityDescription.insertNewObjectForEntityForName("Student", inManagedObjectContext: context) as! Student
            student.name = "陳月娥"
            student.chinese = 74
            student.math = 69
            do {
                try context.save()
            } catch _ {
            }
            student = NSEntityDescription.insertNewObjectForEntityForName("Student", inManagedObjectContext: context) as! Student
            student.name = "鄭麗美"
            student.chinese = 90
            student.math = 81
            do {
                try context.save()
            } catch _ {
            }
            student = NSEntityDescription.insertNewObjectForEntityForName("Student", inManagedObjectContext: context) as! Student
            student.name = "尤阿雄"
            student.chinese = 67
            student.math = 93
            do {
                try context.save()
            } catch _ {
            }
            student = NSEntityDescription.insertNewObjectForEntityForName("Student", inManagedObjectContext: context) as! Student
            student.name = "張金田"
            student.chinese = 70
            student.math = 86
            do {
                try context.save()
            } catch _ {
            }
            do {
                try result = context.executeFetchRequest(fetch) as! [Student]
            } catch let error as NSError {
                print("Fetch failed: \(error.localizedDescription)")
            }
        }
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        return result.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = tableView!.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = "姓名：\(result[indexPath.row].name!)"
        cell.detailTextLabel?.text = "國文：\(result[indexPath.row].chinese!)   數學：\(result[indexPath.row].math!)"
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        buttonInsert.enabled = true
        buttonWrite.enabled = false
        currentStu = indexPath.row
        showSingle(currentStu)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

