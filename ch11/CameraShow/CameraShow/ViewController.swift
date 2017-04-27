import UIKit
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var imagePicker = UIImagePickerController()
    var selectImage:UIImage = UIImage() //使用者選取的圖片
    
    @IBOutlet var imagePhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePhoto.image = UIImage(named: "img01")
    }
    
    @IBAction func cameraClick(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera //使用相機
            imagePicker.mediaTypes = [kUTTypeImage as String] //使用照相
            self.presentViewController(imagePicker, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "無照相裝置", message: "本機無照相裝置，故無法照相！", preferredStyle: .Alert)
            let sureAction = UIAlertAction(title: "確定", style: .Default,handler:nil)
            alertController.addAction(sureAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        selectImage = info[UIImagePickerControllerOriginalImage] as! UIImage! //取得相片
        judgePhoto()
        UIImageWriteToSavedPhotosAlbum(selectImage, nil, nil , nil) //儲存相片
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func chooseClick(sender: UIButton) {
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        selectImage = image //取得選取的圖片
        judgePhoto()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //判斷相片直立或橫放
    func judgePhoto() -> Void {
        if selectImage.size.width > selectImage.size.height { //直立
            imagePhoto.frame.origin.x = 0
            imagePhoto.frame.size.width = 320
            imagePhoto.frame.size.height = 240
        } else { //橫放
            imagePhoto.frame.origin.x = 40
            imagePhoto.frame.size.width = 240
            imagePhoto.frame.size.height = 320
        }
        imagePhoto.image = selectImage
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

