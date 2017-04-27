import UIKit

class ViewController: UIViewController {
    var arrayImage = ["img01", "img02", "img03", "img04", "img05", "img06"] //儲存圖片陣列
    var p:Int = 0 //儲存目前圖片
    var count:Int = 0 //儲存圖片總數量
    
    @IBOutlet weak var imageShow: UIImageView! //ImageView元件
    
    //按 上一張 鈕
    @IBAction func prevClick(sender: UIButton) {
        p-- //目前圖形編號減一
        if p < 0 { //如果編號小於0就設為最後一張
            p = count - 1
        }
        imageShow.image = UIImage(named: arrayImage[p]) //顯示圖片
    }
    
    //按 下一張 鈕
    @IBAction func nextClick(sender: UIButton) {
        p++ //目前圖形編號加一
        if p == count { //如果編號大於圖片總數就設為第一張
            p = 0
        }
        imageShow.image = UIImage(named: arrayImage[p])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageShow.image=UIImage(named: "img01") //開始時顯示第一張
        count = arrayImage.count //取得圖片總數
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

