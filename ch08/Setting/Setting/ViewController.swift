import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefault:NSUserDefaults = NSUserDefaults.standardUserDefaults()

        let defaults:NSDictionary = userDefault.dictionaryRepresentation()
        print("\(defaults)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

