import UIKit
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var imagePicker = UIImagePickerController()
    
    @IBAction func videoTakeClick(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera //使用相機
            imagePicker.mediaTypes = [kUTTypeMovie as String]//使用攝影
            self.presentViewController(imagePicker, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "無攝影裝置", message: "本機無攝影裝置，故無法攝影！", preferredStyle: .Alert)
            let sureAction = UIAlertAction(title: "確定", style: .Default,handler:nil)
            alertController.addAction(sureAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        let tempImage = info[UIImagePickerControllerMediaURL] as! NSURL! //取得拍攝影像
        let pathString = tempImage.relativePath //取得影相相對路徑
        UISaveVideoAtPathToSavedPhotosAlbum(pathString!, self, nil , nil) //儲存影像
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func videoPlayClick(sender: UIButton) {
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        imagePicker.mediaTypes = [kUTTypeMovie as String]
        imagePicker.allowsEditing = true
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

