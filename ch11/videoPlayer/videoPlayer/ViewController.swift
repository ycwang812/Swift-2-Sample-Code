import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    var videoURL:NSURL!
    var player = AVPlayer()
    var playerController = AVPlayerViewController()
    var arrVideo:Array<String> = ["boat", "coast", "robot", "sea", "post"]
    
    @IBOutlet var tableView: UITableView!
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        return arrVideo.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = tableView!.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = arrVideo[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        videoURL = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource(arrVideo[indexPath.row], ofType: "mp4")!) //取得影片檔名稱
        let item = AVPlayerItem(URL: videoURL)
        player = AVPlayer(playerItem: item)
        playerController.player = player
        playerController.view.frame = CGRectMake(0, 320, 375, 292) //設定播放範圍
        self.addChildViewController(playerController)
        self.view.addSubview(playerController.view)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "videoPlayBackDidFinish", name: AVPlayerItemDidPlayToEndTimeNotification, object: item)
        player.play()
        tableView.allowsSelection = false //不能選取檔案
    }
    
    //處理播放完後事件
    func videoPlayBackDidFinish() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: AVPlayerItemDidPlayToEndTimeNotification, object: nil) //移除通知
        player.pause() //停止播放
        player.seekToTime(kCMTimeZero)
        playerController.view.removeFromSuperview() //移除播放視窗
        let alertController = UIAlertController(title: "結束", message: "影片播放完畢！", preferredStyle: .Alert)
        let sureAction = UIAlertAction(title: "確定", style: .Default,handler:nil)
        alertController.addAction(sureAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        tableView.allowsSelection = true //恢復選取檔案
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

