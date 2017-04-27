import UIKit
import MediaPlayer

class ViewController: UIViewController, MPMediaPickerControllerDelegate {
    var mediaPlayer = MPMediaPickerController()
    var musicPlayer = MPMusicPlayerController.applicationMusicPlayer()
    var selectSong:MPMediaItemCollection! //使用者選取的歌曲
    var currentSong:Int = 0 //目前播放的歌曲
    
    @IBOutlet var buttonPlay: UIButton!
    @IBOutlet var textFieldCurrent: UILabel!
    @IBOutlet var textViewList: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textViewList.editable = false
    }
    
    @IBAction func chooseClick(sender: UIButton) {
        mediaPlayer.delegate = self
        mediaPlayer.allowsPickingMultipleItems = true //多選
        musicPlayer.stop() //選曲前先停止播放
        self.presentViewController(mediaPlayer, animated: true, completion: nil)
    }
    
    func mediaPicker(mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        selectSong = mediaItemCollection //取得選取的歌曲
        musicPlayer.setQueueWithItemCollection(mediaItemCollection) //放入播放清單
        musicPlayer.repeatMode = MPMusicRepeatMode.All //重複播放
        musicPlayer.nowPlayingItem = selectSong.items[0] as MPMediaItem //由第一首播放
        musicPlayer.play() //播放歌曲
        textViewList.text = ""
        //在介面顯示歌曲清單
        for var i:Int=0; i<selectSong.items.count; i++ {
            textViewList.text = textViewList.text + selectSong.items[i].title! + "\n"
        }
        buttonPlay.setTitle("暫停", forState: UIControlState.Normal) //將播放鈕設為暫停
        textFieldCurrent.text = selectSong.items[0].title //顯示第一首歌名
        currentSong = 0 //設定目前為第一首
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func playClick(sender: UIButton) {
        if musicPlayer.playbackState == MPMusicPlaybackState.Playing { //是否正在播放
            buttonPlay.setTitle("播放", forState: UIControlState.Normal)
            musicPlayer.pause()
        } else {
            buttonPlay.setTitle("暫停", forState: UIControlState.Normal)
            musicPlayer.play()
        }
    }
    
    @IBAction func prevClick(sender: UIButton) {
        musicPlayer.skipToPreviousItem() //播放上一首
        --currentSong //目前歌曲減1
        if currentSong < 0 { //若小於0就移到最後一首
            currentSong = selectSong.items.count - 1
        }
        textFieldCurrent.text = selectSong.items[currentSong].title
    }
    
    @IBAction func nextClick(sender: UIButton) { //播放下一首
        musicPlayer.skipToNextItem() //播放下一首
        ++currentSong //目前歌曲加1
        if currentSong == selectSong.items.count { //若超過最後就移到第一首
            currentSong = 0
        }
        textFieldCurrent.text = selectSong.items[currentSong].title
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

