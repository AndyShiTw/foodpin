//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by HSU JUI-FU on 2018/2/25.
//  Copyright © 2018年 AndyShi. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    @IBOutlet var restaurantImageView : UIImageView!
    @IBOutlet var restaurantNameLabel : UILabel!
    @IBOutlet var restaurantTypeLabel : UILabel!
    @IBOutlet var restaurantLoactionLabel : UILabel!
    var restaurantName = ""
    var restaurantType = ""
    var restaurantLocation = ""
    var restaurantImage = #imageLiteral(resourceName: "cafelore");
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        restaurantImageView.image = restaurantImage;
        restaurantNameLabel.text = restaurantName;
        restaurantTypeLabel.text = restaurantType;
        restaurantLoactionLabel.text = restaurantLocation;
        
        // 停止大標題顯示
        // .always是一直使用
        // .automatic是繼承上一個頁面的大標題
        navigationItem.largeTitleDisplayMode = .never
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
