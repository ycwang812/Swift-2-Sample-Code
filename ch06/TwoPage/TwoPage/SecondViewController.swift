import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonClick(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
