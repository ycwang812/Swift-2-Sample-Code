import UIKit
import AVFoundation

class ViewController: UIViewController {
    var arrSong:Array<String> = ["greensleeves", "mario", "songbird", "summersong", "tradewinds"] //音樂名稱陣列
    var audioPlayer = AVAudioPlayer() //播放音樂物件
    var timer = NSTimer() //定期執行物件
    var currentTime:Double = 0.0 //目前播放時間
    
    @IBOutlet weak var labelSongname: UILabel!
    @IBOutlet var sliderProgress: UISlider! //進度滑桿
    @IBOutlet var sliderVolumn: UISlider! //聲音滑桿
    @IBOutlet var buttonPlay: UIButton!
    @IBOutlet var buttonPause: UIButton!
    @IBOutlet var buttonStop: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonShow(false, pause: false, stop: false, progress: false, volume: false)
    }
    
    //進度滑桿
    @IBAction func sldProgChange(sender: UISlider) {
        audioPlayer.currentTime = audioPlayer.duration * Double(sender.value)
    }
    
    //聲音滑桿：0.0 到 1.0 之間
    @IBAction func sldVolumnChange(sender: UISlider) {
        audioPlayer.volume = sliderVolumn.value
    }
    
    //播放按鈕
    @IBAction func playClick(sender: UIButton) {
        audioPlayer.play()
        buttonShow(false, pause: true, stop: true, progress: true, volume: true)
    }
    
    //暫停按鈕
    @IBAction func pauseClick(sender: UIButton) {
        audioPlayer.pause()
        buttonShow(true, pause: false, stop: true, progress: true, volume: true)
    }
    
    //停止按鈕
    @IBAction func stopClick(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        sliderProgress.value = 0
        buttonShow(true, pause: false, stop: false, progress: false, volume: false)
    }
    
    //播放 暫停 停止 按鈕是否有效
    func buttonShow(play:Bool, pause:Bool, stop:Bool, progress:Bool, volume:Bool) {
        buttonPlay.enabled = play
        buttonPause.enabled = pause
        buttonStop.enabled = stop
        sliderProgress.enabled = progress
        sliderVolumn.enabled = volume
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
        let soundCurrent = NSURL(fileURLWithPath:NSBundle.mainBundle().pathForResource(arrSong[indexPath.row], ofType: "mp3")!)
        var error:NSError?
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: soundCurrent)
        } catch let error1 as NSError {
            error = error1
            audioPlayer.finalize()
        }
        if (error != nil) {
            let alertController = UIAlertController(title: "錯誤", message: error?.localizedDescription, preferredStyle: .Alert)
            let sureAction = UIAlertAction(title: "確定", style: .Default,handler:nil)
            alertController.addAction(sureAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            buttonShow(false, pause: true, stop: true, progress: true, volume: true)
            timer.invalidate() //停止前次的計時器
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: "refresh", userInfo: nil, repeats: true) //啟動計時器
        }
    }
    
    //定時更新進度滑桿位置
    func refresh() {
        sliderProgress.value = Float(audioPlayer.currentTime / audioPlayer.duration)
        //播放完音樂
        if sliderProgress.value > 0.99 {
            buttonShow(true, pause: false, stop: false, progress: false, volume: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

