//
//  WallthroughPageViewController.swift
//  FoodPin
//
//  Created by HSU JUI-FU on 2018/3/31.
//  Copyright © 2018年 AndyShi. All rights reserved.
//

import UIKit
protocol WalkthroughPageViewControllerDelegate: class {
    func didUpdatePageindex(current:Int)
}

class WallthroughPageViewController: UIPageViewController,UIPageViewControllerDataSource,UIPageViewControllerDelegate {

    // weak防止記憶體洩漏
    weak var walkthroughDelegate: WalkthroughPageViewControllerDelegate?
    var pageHeadings = ["Create Your Own Food Guide","Show you the location","Discover greate restaurant"]
    var pageImages = ["onboarding-1","onboarding-2","onboarding-3"]
    var pageSubHeadings = ["Pin your favorite restaurant and create your own food guide","Search and locate your favourite restaurant on Maps","find restaurants shared by your friend and other foodies"]
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        dataSource = self
        delegate = self
        
        if let startingViewController = contentViewController(at: 0){
            setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let contentViewController = pageViewController.viewControllers?.first as? WalkthroughContentViewController {
                currentIndex = contentViewController.index
                
                walkthroughDelegate?.didUpdatePageindex(current: currentIndex)
            }
        }
    }

    
    func forwardPage() {
        currentIndex += 1
        if let nextViewController = contentViewController(at: currentIndex){
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,viewControllerBefore viewController:UIViewController) -> UIViewController?{
        
        var index = (viewController as! WalkthroughContentViewController).index
        index -= 1
    
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,viewControllerAfter viewController:UIViewController) -> UIViewController?{
        
        var index = (viewController as! WalkthroughContentViewController).index
        index += 1
        
        return contentViewController(at: index)
    }
    
    func contentViewController(at index: Int) -> WalkthroughContentViewController? {
        if index < 0 || index >= pageHeadings.count{
            return nil
        }
        
        // 建立新的viewController並傳遞資料
        let storyBoard = UIStoryboard(name:"OnBoarding",bundle:nil)
        if let pageContentViewController = storyBoard.instantiateViewController(withIdentifier: "WalkthroughContentViewController") as? WalkthroughContentViewController {
            
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.heading = pageHeadings[index]
            pageContentViewController.subHeading = pageSubHeadings[index]
            pageContentViewController.index = index
            
            return pageContentViewController
        }
        
        return nil
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
