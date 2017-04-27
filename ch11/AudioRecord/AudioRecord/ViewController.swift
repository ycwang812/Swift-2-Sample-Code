import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate {
    var recorder:AVAudioRecorder! //錄音物件
    var audioPlayer:AVAudioPlayer! //播放物件
    var filemanager = NSFileManager.defaultManager() //檔案管理物件
    var path = NSHomeDirectory() + "/Documents/" //存檔目錄
    var arrFile:Array<String> = [] //儲存檔案陣列
    var fileName:String = "" //檔案名稱
    var timer:NSTimer = NSTimer()
    
    @IBOutlet var labelMsg: UILabel!
    @IBOutlet var buttonRecord: UIButton!
    @IBOutlet var buttonPlay: UIButton!
    @IBOutlet var buttonDelete: UIButton!
    @IBOutlet var tableViewFile: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrFile = filemanager.subpathsAtPath(path)! as Array<String> //取得所有錄音檔
        tableViewFile.reloadData() //顯示檔案列表
        buttonEnable(true, play:false, delete:false)
    }
    
    @IBAction func recordClick(sender: UIButton) {
        if buttonRecord.titleLabel?.text == "開始錄音" { //按 開始錄音 鈕
            let session:AVAudioSession = AVAudioSession.sharedInstance()
            if (session.respondsToSelector("requestRecordPermission:")) { //檢查授權
                AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
                    if granted { //取得授權
                        do {
                            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
                        } catch _ {
                        }
                        do {
                            try session.setActive(true)
                        } catch _ {
                        }
                        //以日期做為檔案名稱
                        let dateFormat = NSDateFormatter()
                        dateFormat.dateFormat="yyyyMMddHHmmss"
                        self.fileName = dateFormat.stringFromDate(NSDate()) + ".s4a"
                        let filePath = self.path + self.fileName //檔案路徑
                        let fileURL = NSURL(fileURLWithPath: filePath)
                        var error: NSError?
                        do {
                            self.recorder = try AVAudioRecorder(URL: fileURL, settings: ["":""])
                        } catch let error1 as NSError {
                            error = error1
                            self.recorder = nil
                        } catch {
                            fatalError()
                        }
                        if let err = error {
                            self.alertOneBtn("錯誤", pMessage:err.localizedDescription, btnTitle:"確定")
                        } else { //開始錄音
                            self.buttonRecord.setTitle("停止錄音", forState: UIControlState.Normal)
                            self.labelMsg.text = "正在錄音：" + self.fileName
                            self.buttonEnable(true, play:false, delete:false)
                            self.recorder.delegate = self
                            self.recorder.prepareToRecord()
                            self.recorder.record()
                        }
                    } else{
                        self.alertOneBtn("失敗", pMessage:"你的裝置不允許錄音！", btnTitle:"確定")
                    }
                })
            }
        } else { //按 停止錄音 鈕
            buttonRecord.setTitle("開始錄音", forState: UIControlState.Normal)
            labelMsg.text = "錄音結束：" + self.fileName
            buttonEnable(true, play:true, delete:true)
            recorder.stop()
            arrFile.append(fileName) //加入新檔名
            tableViewFile.reloadData()
        }
    }
    
    @IBAction func playClick(sender: UIButton) {
        if buttonPlay.titleLabel?.text == "開始播放" { //按 開始播放 鈕
            buttonPlay.setTitle("停止播放", forState: UIControlState.Normal)
            labelMsg.text = fileName
            buttonEnable(false, play:true, delete:false)
            playSound()
        } else { //按 停止播放 鈕
            audioPlayer.stop()
            buttonPlay.setTitle("開始播放", forState: UIControlState.Normal)
            labelMsg.text = fileName
            buttonEnable(true, play:true, delete:true)
            timer.invalidate()
        }
    }
    
    @IBAction func deleteClick(sender: UIButton) { //按 刪除檔案 鈕
        let filePath = path + fileName
        var flag: Bool
        do {
            try filemanager.removeItemAtPath(filePath)
            flag = true
        } catch _ {
            flag = false
        } //刪除檔案
        if flag { //刪除成功
            alertOneBtn("成功", pMessage:"檔案刪除成功！", btnTitle:"確定")
            let n:Int = arrFile.indexOf(fileName)! //尋找檔案名稱
            arrFile.removeAtIndex(n) //移除檔案名稱
            labelMsg.text = "無檔名！"
            buttonEnable(true, play:false, delete:true)
        } else { //刪除失敗
            alertOneBtn("失敗", pMessage:"檔案刪除失敗！", btnTitle:"確定")
        }
        tableViewFile.reloadData() //更新檔案列表
    }
    
    func playSound() { //播放聲音檔
        let filePath = path + fileName
        let soundCurrent = NSURL(fileURLWithPath: filePath)
        var error:NSError?
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: soundCurrent)
        } catch let error1 as NSError {
            error = error1
            audioPlayer = nil
        }
        if (error != nil) {
            alertOneBtn("錯誤", pMessage:(error?.localizedDescription)!, btnTitle:"確定")
        } else {
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            buttonPlay.setTitle("停止播放", forState: UIControlState.Normal)
            labelMsg.text = fileName
            timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("ticker"), userInfo: nil, repeats: true)
        }
    }
    
    func ticker() { //檢查是否播完
        if audioPlayer.currentTime > (audioPlayer.duration - 0.6) {
            buttonPlay.setTitle("開始播放", forState: UIControlState.Normal)
            buttonEnable(true, play:true, delete:true)
            timer.invalidate()
        }
    }
    
    func buttonEnable(record:Bool, play:Bool, delete:Bool) {
        buttonRecord.enabled = record
        buttonPlay.enabled = play
        buttonDelete.enabled = delete
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        return arrFile.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = tableView!.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = arrFile[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        fileName = arrFile[indexPath.row]
        buttonEnable(false, play:true, delete:false)
        playSound()
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

