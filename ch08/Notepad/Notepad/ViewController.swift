import UIKit

class ViewController: UIViewController {
    var txtFileList:Array<String> = [] //檔案名稱陣列
    var fm:NSFileManager = NSFileManager() //建立檔案管理物件
    var rootPath = NSHomeDirectory() + "/Documents/" //根目錄
    
    @IBOutlet var textFieldFilename: UITextField!
    @IBOutlet var textViewContent: UITextView!
    @IBOutlet var tableViewFile: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtFileList.removeAll(keepCapacity: true) //清除檔案列表
        let fileList = ((fm.subpathsAtPath(rootPath) )) //取得所有檔案名稱
        //取得附加檔名為 .txt 的檔案
        for file in fileList! {
            let nsfile = file as NSString;
            if nsfile.substringWithRange(NSRange(location:nsfile.length-4, length: 4)) == ".txt" {
                txtFileList.append(file as String)
            }
        }
    }
    
    @IBAction func saveClick(sender: UIButton) {
        if textViewContent.text=="" || textFieldFilename.text=="" {
            alertOneBtn("輸入確認", pMessage:"文件名稱及內容都必須輸入！", btnTitle:"確定")
        } else {
            let file:NSString = textFieldFilename.text!
            //若字尾不是 .txt 就加上 .txt
            if file.length <= 4 || file.substringWithRange(NSRange(location: file.length-4, length: 4)) != ".txt" {
                textFieldFilename.text = textFieldFilename.text! + ".txt"
            }
            let fileName = rootPath + textFieldFilename.text! //完整路徑
            var flag: Bool
            do {
                try textViewContent.text.writeToFile(fileName, atomically: true, encoding: NSUTF8StringEncoding)
                flag = true
            } catch _ {
                flag = false
            } //寫入檔案
            if flag { //寫入成功
                alertOneBtn("成功", pMessage:"文件寫入成功！", btnTitle:"確定")
                if txtFileList.indexOf(textFieldFilename.text!) == nil { //新檔案
                    txtFileList.append(textFieldFilename.text!) //加入檔案名稱陣列
                }
            } else { //寫入失敗
                alertOneBtn("失敗", pMessage:"文件寫入失敗！", btnTitle:"確定")
            }
        }
        tableViewFile.reloadData() //更新檔案列表
    }
    
    @IBAction func deleteClick(sender: UIButton) {
        if textFieldFilename.text=="" { //文件名稱未輸入
            alertOneBtn("選取", pMessage:"文件名稱必須選取！", btnTitle:"確定")
        } else {
            let fileName = rootPath + textFieldFilename.text! //完整路徑
            var flag: Bool
            do {
                try fm.removeItemAtPath(fileName)
                flag = true
            } catch _ {
                flag = false
            } //刪除檔案
            if flag { //刪除成功
                alertOneBtn("成功", pMessage:"文件刪除成功！", btnTitle:"確定")
                //由檔案列表移除檔案名稱
                let n:Int = txtFileList.indexOf(textFieldFilename.text!)!
                txtFileList.removeAtIndex(n)
                //清除輸入框及內容
                textFieldFilename.text = ""
                textViewContent.text = ""
            } else { //刪除失敗
                alertOneBtn("失敗", pMessage:"文件刪除失敗！", btnTitle:"確定")
            }
            tableViewFile.reloadData() //更新檔案列表
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return txtFileList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        // 設定儲存格的內容
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = txtFileList[indexPath.row] //列表項目內容
        return cell
    }
    
    //選取檔案名稱
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //取得檔案內容
        textFieldFilename.text = txtFileList[indexPath.row]
        let fileName = rootPath + textFieldFilename.text!
        let readContent = try? NSString(contentsOfFile: fileName, encoding: NSUTF8StringEncoding)
        textViewContent.text = readContent as! String //顯示檔案內容
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

