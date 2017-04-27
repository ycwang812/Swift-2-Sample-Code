import UIKit
import CoreData

class ViewController: UIViewController {
    var result:Array<Student> = [] //存資料庫的陣列
    
    @IBOutlet var tableViewCore: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDele:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context:NSManagedObjectContext = appDele.managedObjectContext
        //讀取資料庫
        let fetch:NSFetchRequest = NSFetchRequest(entityName: "Student")
        do {
            try result = context.executeFetchRequest(fetch) as! [Student]
        } catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }
        initData()
        tableViewCore.reloadData()
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
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

