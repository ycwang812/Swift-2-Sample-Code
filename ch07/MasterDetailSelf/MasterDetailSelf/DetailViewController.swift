import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var textViewContent: UITextView!


    var detailItem: Dictionary<String,String>? { //傳過來的是Dictionay
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        if let detail: Dictionary<String,String> = self.detailItem { //傳過來的是Dictionay
            if let label1 = self.labelName { //顯示名稱
                label1.text = detail["name"]!
            }
            if let label2 = self.labelTime { //顯示日期
                label2.text = detail["time"]
            }
            if let text1 = self.textViewContent { //顯示內容
                text1.text = detail["content"]
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

