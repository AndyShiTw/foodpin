//
//  WalkthroughViewViewController.swift
//  FoodPin
//
//  Created by HSU JUI-FU on 2018/3/31.
//  Copyright © 2018年 AndyShi. All rights reserved.
//

import UIKit

class WalkthroughViewController: UIViewController,WalkthroughPageViewControllerDelegate {
    @IBOutlet var pageControl :UIPageControl!
    @IBOutlet var nextButton : UIButton!{
        didSet {
            nextButton.layer.cornerRadius = 25.0
            nextButton.layer.masksToBounds = true
        }
    }
    @IBOutlet var skipButton : UIButton!
    
    @IBAction func skipButtonTapped(sender:UIButton){
        UserDefaults.standard.set(true,forKey:"hasViewedWalkthrough")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(sender:UIButton){
        if let index = walkthroughPageViewController?.currentIndex{
            switch index {
            case 0...1:
                walkthroughPageViewController?.forwardPage()
            case 2:
                UserDefaults.standard.set(true,forKey:"hasViewedWalkthrough")
                dismiss(animated: true, completion: nil)
            default:
                break
            }
        }
            
        updateUI()
    }
    
    var walkthroughPageViewController : WallthroughPageViewController?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageViewController = destination as? WallthroughPageViewController {
            walkthroughPageViewController = pageViewController
            walkthroughPageViewController?.walkthroughDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didUpdatePageindex(current: Int) {
        updateUI()
    }
    
    func updateUI() {
        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
            case 0...1:
                nextButton.setTitle("NEXT", for: .normal)
                skipButton.isHidden = false
            case 2:
                nextButton.setTitle("GET STARTED", for: .normal)
                skipButton.isHidden = true
            default:
                break
            }
            
            pageControl.currentPage = index
        }
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
