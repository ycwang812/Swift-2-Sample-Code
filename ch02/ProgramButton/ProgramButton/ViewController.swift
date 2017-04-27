import UIKit

class ViewController: UIViewController {
    @IBOutlet var labelTel: UILabel! //連結電話輸入欄位
    @IBOutlet var labelMsg: UILabel! //連結訊息欄位

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //以程式建立12個按鈕
        for i in 0 ..< 12 += 1 {
            let x:Int = 80 + (i % 4) * 60 //按鈕水平坐標
            let y:Int = 95 + (i / 4) * 50 //按鈕垂直坐標
            let buttonNumber:UIButton = UIButton(type: UIButtonType.system) as UIButton //建立按鈕物件
            buttonNumber.frame = CGRect(x: x, y: y, width: 41, height: 35) //按鈕位置及大小
            buttonNumber.setTitleColor(UIColor.white, for: UIControlState()) //文字顏色
            buttonNumber.backgroundColor = UIColor.black //按鈕背景色
            buttonNumber.titleLabel?.font = UIFont(name: "System", size: 22.0) //字型大小
            if i==10 { //第11個是 清除 鈕
                buttonNumber.setTitle("清除", for: UIControlState())
                buttonNumber.addTarget(self, action:#selector(ViewController.clearClick(_:)), for:UIControlEvents.touchUpInside)
            } else if i==11 { //第12個是 確定 鈕
                buttonNumber.setTitle("確定", for: UIControlState())
                buttonNumber.addTarget(self, action:#selector(ViewController.sureClick(_:)), for:UIControlEvents.touchUpInside)
            } else {
                buttonNumber.setTitle("\(i)", for: UIControlState())
                buttonNumber.addTarget(self, action:#selector(ViewController.numberClick(_:)), for:UIControlEvents.touchUpInside)
            }
            view.addSubview(buttonNumber)
        }
    }
    
    func numberClick(_ sender:UIButton) {
        labelTel.text = labelTel.text! + sender.currentTitle!
    }

    func clearClick(_ sender:UIButton) {
        labelTel.text = ""
    }
    
    func sureClick(_ sender:UIButton) {
        if labelTel.text?.lengthOfBytes(using: String.Encoding.utf8) == 10 { //輸入10個數字
            labelMsg.text = "撥打電話：" + labelTel.text!
        } else {
            labelMsg.text = "必須輸入10個數字！"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

