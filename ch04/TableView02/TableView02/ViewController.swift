import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    @IBOutlet weak var labelBall: UILabel!
    var balls:Array<String> = ["籃球","足球","棒球","其他"]
    
    // 點選儲存格的處理
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let choice:String = balls[indexPath.row]
        labelBall.text = "最喜歡的球類：\(choice)"
    }
    
    // 設定表格只有一個區段
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // 設定表格的列數
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return balls.count
    }
    
    // 表格的儲存格設定
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        // 設定儲存格的內容
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = balls[indexPath.row]
        return cell
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