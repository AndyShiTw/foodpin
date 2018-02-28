//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by HSU JUI-FU on 2018/2/25.
//  Copyright © 2018年 AndyShi. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
//    @IBOutlet var restaurantImageView : UIImageView!
//    @IBOutlet var restaurantNameLabel : UILabel!
//    @IBOutlet var restaurantTypeLabel : UILabel!
//    @IBOutlet var restaurantLoactionLabel : UILabel!
    @IBOutlet var tableView : UITableView!
    @IBOutlet var headerView : RestaurantDetailHeaderView!
    // UIImage就是圖片檔案類型的資料型態
    // var restaurantImage : UIImage?
    
    var restaurant : Restaurant = Restaurant()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //連結DataSource Delegate
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
        // 舊的細節畫面
        /*
        restaurantImageView.image = UIImage(named:restaurant.image);
        restaurantNameLabel.text = restaurant.name;
        restaurantTypeLabel.text = restaurant.type;
        restaurantLoactionLabel.text = restaurant.location;
        */
        headerView.nameLabel.text = restaurant.name;
        headerView.typeLabel.text = restaurant.type;
        headerView.headerImageView.image = UIImage(named:restaurant.image);
        headerView.heartImageView.isHidden = !restaurant.isVisited
        
        // 停止大標題顯示
        // .always是一直使用
        // .automatic是繼承上一個頁面的大標題
        navigationItem.largeTitleDisplayMode = .never
        
        // 移除cell的格線
        tableView.separatorStyle = .none
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 給tablecell資料使用的
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0 :
            print(String(describing: RestaurantDetailIconTextCell.self))
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:RestaurantDetailIconTextCell.self),for:indexPath) as! RestaurantDetailIconTextCell
            cell.iconImageView.image = UIImage(named:"phone")
            cell.shortTextLabel.text = restaurant.phone
            return cell
        case 1 :
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:RestaurantDetailIconTextCell.self),for:indexPath) as! RestaurantDetailIconTextCell
            cell.iconImageView.image = UIImage(named:"map")
            cell.shortTextLabel.text = restaurant.location
            
            return cell
        case 2 :
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:RestaurantDetailTextCell.self),for:indexPath) as! RestaurantDetailTextCell
            cell.descriptionLabel.text = restaurant.description
            
            return cell
        default:
            fatalError("Error")
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
