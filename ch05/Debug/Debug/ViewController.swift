import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textNum: UITextField!
    @IBOutlet weak var labelResult: UILabel!
    
    @IBAction func buttonClick(sender: UIButton) {
        let n:Int? = Int(textNum.text!)
        if n != nil{
            let total:Int = calaulate(n!)
            labelResult.text = "總和=\(total)"
        }else{
            print("型別錯誤!")
        }
    }
    
    func calaulate(n:Int) -> Int {
        // 求 1+2+3+… +n 之和
        var sum:Int = 0
        for var i:Int=0; i<=n; i++ {
            sum = sum + i
        }
        return sum
    }
    
}