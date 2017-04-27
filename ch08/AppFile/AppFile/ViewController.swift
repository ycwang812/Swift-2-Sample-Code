import UIKit

class ViewController: UIViewController {
    var arrayTitle:Array<String> = [] //存書名陣列
    var arrayImg:Array<String> = [] //存圖片名稱陣列
    var arrayContent:Array<String> = [] //存書籍介紹陣列
    
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var imageBook: UIImageView!
    @IBOutlet var textViewContent: UILabel!
    @IBOutlet var labelNum: UILabel!
    @IBOutlet var stepperBook: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var path:NSString = NSBundle.mainBundle().pathForResource("img", ofType: "txt")! //取得img.txt檔路徑
        let imgName = NSData(contentsOfFile: path as String) //取得檔案內容
        let imgString: String = NSString(data:imgName!, encoding:NSUTF8StringEncoding)! as String //轉換為字串
        var arrayImage = imgString.componentsSeparatedByString("\n") //以分行符號分解字串
        //以迴圈分解字串後依次存入書名及圖片陣列
        for var i:Int=0; i<arrayImage.count; i++ {
            var arrayTem = arrayImage[i].componentsSeparatedByString(";")
            arrayImg.append(arrayTem[0])
            arrayTitle.append(arrayTem[1])
        }
        
        path = NSBundle.mainBundle().pathForResource("appfile", ofType: "txt")!
        let contentData = NSData(contentsOfFile: path as String)
        let contentString: String = NSString(data:contentData!, encoding:NSUTF8StringEncoding)! as String
        arrayContent = contentString.componentsSeparatedByString("\n")
        //顯示第一筆資料
        labelTitle.text = arrayTitle[0]
        imageBook.image = UIImage(named: arrayImg[0])
        textViewContent.text = arrayContent[0]
        //設定stepper元件初始值
        stepperBook.minimumValue = 0
        stepperBook.maximumValue = Double(arrayTitle.count) + 1
        stepperBook.value = 1
    }
    
    @IBAction func stepperChange(sender: UIStepper) {
        var num:Int = Int(stepperBook.value) //取得stepper元件值
        if num == arrayTitle.count + 1 { //若超過最後一筆則回到第一筆
            num = 1
            stepperBook.value = 1
        } else if num == 0 { //若到第0筆則移到最後一筆
            num = arrayTitle.count
            stepperBook.value = Double(arrayTitle.count)
        }
        //顯示資料
        labelTitle.text = arrayTitle[num-1]
        imageBook.image = UIImage(named: arrayImg[num-1])
        textViewContent.text = arrayContent[num-1]
        labelNum.text = String(num)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

