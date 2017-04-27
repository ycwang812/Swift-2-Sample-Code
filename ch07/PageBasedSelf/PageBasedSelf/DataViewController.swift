import UIKit

class DataViewController: UIViewController {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var labelPoem: UILabel!

    var dataObject: String = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let obj: AnyObject = dataObject {
            let content:String = obj.description
            var result:Array<String> = content.componentsSeparatedByString("|")
            self.labelTitle.text = result[0]
            self.labelAuthor.text = result[1]
            self.labelPoem!.text = result[2]
        }
    }


}

