//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by HSU JUI-FU on 2018/3/12.
//  Copyright © 2018年 AndyShi. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    @IBOutlet var backgroundImageView : UIImageView!
    // 按鈕陣列
    @IBOutlet var ratingButtons : [UIButton]!
    @IBOutlet var crossButton : UIButton!
    
    var restaurant = Restaurant()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        backgroundImageView.image = UIImage(named:restaurant.image)
        
        // 使用模糊效果
        let blurEffect = UIBlurEffect(style:.dark)
        let blurEffectView = UIVisualEffectView(effect:blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        // 將起始點設定在X600
        let moveRightTransform = CGAffineTransform.init(translationX: 600, y: 0)
        // 設定從五倍的大小
        let scaleUpTransform = CGAffineTransform.init(scaleX: 5.0, y: 5.0)
        // 組合縮放跟位移的功能
        let moveScaleTransform = scaleUpTransform.concatenating(moveRightTransform)
        
        // 隱藏按鈕
        for ratingButton in ratingButtons{
            ratingButton.alpha = 0
            ratingButton.transform = moveScaleTransform
        }
        
        //叉叉按鈕的動畫
        let moveDownTransform = CGAffineTransform.init(translationX:0,y:-200)
        crossButton.transform = moveDownTransform
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        for index in 0...ratingButtons.count-1 {
            UIView.animate(withDuration: 0.4,delay:0.1*Double(index+1), usingSpringWithDamping:0.2, initialSpringVelocity:0.3, options:[],animations: {
                self.ratingButtons[index].alpha = 1
                // 取消位置移動，回歸到原點
                self.ratingButtons[index].transform = .identity
            },completion:nil)
        }
        
        UIView.animate(withDuration: 0.4,delay:0.1, animations: {
            self.crossButton.transform = .identity
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
