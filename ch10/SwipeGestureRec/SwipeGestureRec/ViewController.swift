import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var img: UIImageView!
    
    @IBAction func up(sender: UISwipeGestureRecognizer) {
        img.frame.origin.y -= 10
    }
    
    @IBAction func left(sender: UISwipeGestureRecognizer) {
        img.frame.origin.x -= 10
    }
    
    @IBAction func right(sender: UISwipeGestureRecognizer) {
        img.frame.origin.x += 10
    }
    
    @IBAction func down(sender: UISwipeGestureRecognizer) {
        img.frame.origin.y += 10
    }

}