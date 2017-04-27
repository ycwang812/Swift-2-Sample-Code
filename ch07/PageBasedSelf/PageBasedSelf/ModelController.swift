import UIKit

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */


class ModelController: NSObject, UIPageViewControllerDataSource {

    var pageData: [String] = []


    override init() {
        super.init()
        
        var title:Array<String> = ["下江陵", "閨怨", "九月九日憶山東兄弟"] //標題
        var author:Array<String> = ["李白", "王昌齡" ,"王維"] //作者
        //唐詩內容
        let poem1 = "朝辭白帝彩雲間，\n千里江陵一日還。\n兩岸猿聲啼不住，\n輕舟已過萬重山。"
        let poem2 = "閨中少婦不知愁，\n春日凝妝上翠樓。\n忽見陌頭楊柳色，\n悔教夫婿覓封侯。"
        let poem3 = "獨在異鄉為異客，\n每逢佳節倍思親。\n遙知兄弟登高處，\n遍插茱萸少一人。"
        var poem:Array<String> = [poem1, poem2, poem3]
        //將標題,作者,內容以 ｜符號分隔組成字串
        var content:Array<String> = []
        for var i:Int=0; i<3; i++ {
            content.append(title[i] + "|" + author[i] + "|" + poem[i] + "|")
        }
        pageData = [content[0], content[1], content[2]] //建立顯示字串
    }

    func viewControllerAtIndex(index: Int, storyboard: UIStoryboard) -> DataViewController? {
        // Return the data view controller for the given index.
        if (self.pageData.count == 0) || (index >= self.pageData.count) {
            return nil
        }

        // Create a new view controller and pass suitable data.
        let dataViewController = storyboard.instantiateViewControllerWithIdentifier("DataViewController") as! DataViewController
        dataViewController.dataObject = self.pageData[index]
        return dataViewController
    }

    func indexOfViewController(viewController: DataViewController) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
        return pageData.indexOf(viewController.dataObject) ?? NSNotFound
    }

    // MARK: - Page View Controller Data Source

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index--
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController)
        if index == NSNotFound {
            return nil
        }
        
        index++
        if index == self.pageData.count {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }

}

