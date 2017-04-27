import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    @IBOutlet weak var labelBall: UILabel!
    @IBOutlet weak var textBall: UITextField!
    @IBOutlet weak var myTableView: UITableView!
    // 建立 NSMutableArray 型別陣列
    var balls:NSMutableArray = ["籃球","足球","棒球","其他"]
    
    // 新增資料
    @IBAction func insert(sender: UIButton) {
        balls.addObject(textBall.text!)
        myTableView.reloadData()
    }
    
    // 設定滑動後顯示紅色刪除按鈕
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle{
        return UITableViewCellEditingStyle.Delete
    }
    
    // 按下刪除按鈕，刪除該儲存格資料
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        // 刪除陣列資料
        balls.removeObjectAtIndex(indexPath.row)
        // 刪除該儲存格資料
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
    
    // UISwitch 切換
    @IBAction func valueChanged(sender: UISwitch) {
        if sender.on  {
            self.myTableView.editing = true
        }else{
            self.myTableView.editing = false
        }
    }
    
    // 設定表格的列數
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return balls.count
    }
    
    // 表格的儲存格設定
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        // 設定儲存格的內容
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = balls.objectAtIndex(indexPath.row) as! NSString as String
        return cell
    }
    
    // 點選儲存格的處理
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let choice:AnyObject = balls[indexPath.row]
        labelBall.text = "最喜歡的球類：\(choice)"
    }
    
    // 允許拖曳
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool{
        return true
    }
    
    // 移動資料
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath){
        balls.exchangeObjectAtIndex(sourceIndexPath.row, withObjectAtIndex: destinationIndexPath.row)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

