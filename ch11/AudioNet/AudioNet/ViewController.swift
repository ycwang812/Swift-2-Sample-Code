import UIKit
import AVFoundation

class ViewController: UIViewController {
    var arrSong:Array<String> = ["greennet", "marionet", "birdnet", "summernet", "tradenet"] //網路音樂名稱陣列
    var player = AVPlayer()
    var timer = NSTimer() //定期執行物件
    
    @IBOutlet var labelSongname: UILabel!
    @IBOutlet var sliderProgress: UISlider! //進度滑桿
    @IBOutlet var buttonPlay: UIButton!
    @IBOutlet var buttonPause: UIButton!
    @IBOutlet var buttonStop: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonShow(false, pause: false, stop: false)
    }
    
    //進度滑桿
    @IBAction func sldProgChange(sender: UISlider) {
        let preferredTimeScale : Int32 = 1
        let seconds : Int64 = Int64(Float(CMTimeGetSeconds(player.currentItem!.asset.duration)) * Float(sender.value))
        player.seekToTime(CMTimeMake(seconds,preferredTimeScale))
    }
    
    //播放按鈕
    @IBAction func playClick(sender: UIButton) {
        player.play()
        buttonShow(false, pause: true, stop: true)
    }
    
    //暫停按鈕
    @IBAction func pauseClick(sender: UIButton) {
        player.pause()
        buttonShow(true, pause: false, stop: true)
    }
    
    //停止按鈕
    @IBAction func stopClick(sender: UIButton) {
        player.pause()
        player.seekToTime(kCMTimeZero)
        buttonShow(true, pause: false, stop: false)
    }
    
    //播放 暫停 停止 按鈕是否有效
    func buttonShow(play:Bool, pause:Bool, stop:Bool) {
        buttonPlay.enabled = play
        buttonPause.enabled = pause
        buttonStop.enabled = stop
        
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        return arrSong.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell: UITableViewCell = tableView!.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel!.text = arrSong[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        labelSongname.text = arrSong[indexPath.row]
        player.pause()
        player.seekToTime(kCMTimeZero)
        let url = "http://www.e-happy.com.tw/gate/music/" + arrSong[indexPath.row] + ".mp3"
        player = AVPlayer(URL:NSURL(string: url)!)
        player.play()
        buttonShow(false, pause: true, stop: true)
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "refresh", userInfo: nil, repeats: true)
    }
    
    //定時更新進度滑桿位置
    func refresh() {
        let seconds : Float = Float(CMTimeGetSeconds(player.currentTime())) / Float(CMTimeGetSeconds(player.currentItem!.asset.duration))
        sliderProgress.value = seconds
        //播放完音樂
        if sliderProgress.value > 0.99 {
            buttonShow(true, pause: false, stop: false)
            player.pause()
            player.seekToTime(kCMTimeZero)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

