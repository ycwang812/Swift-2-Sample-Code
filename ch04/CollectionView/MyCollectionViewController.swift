import UIKit

class MyCollectionViewController: UICollectionViewController {
    @IBOutlet var ColletionView: UICollectionView!
    var imgAry = ["img01.jpg","img02.jpg","img03.jpg","img04.jpg","img05.jpg","img06.jpg"]
    
    // 設定表格的數目
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgAry.count
    }
    
    // 儲存格設定
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        // 取得 CustomCell 自訂類別的 cell 儲存格
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomCell
        
        cell.labelName.text = "編號：\(indexPath.row)"
        cell.imageName.image = UIImage(named: imgAry[indexPath.row])
        return cell
    }
    
    // 點選儲存格的處理
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        print("選取 \(imgAry[indexPath.row]) 圖片")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
