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
    
    // 透過segue傳遞資料給map view controller
    override func prepare(for segue: UIStoryboardSegue , sender : Any?){
        if segue.identifier == "showMap"{
            let destinationController = segue.destination as! MapViewController
            destinationController.restaurant = restaurant
        }
        
        if segue.identifier == "showReview"{
            let destinationController = segue.destination as! ReviewViewController
            destinationController.restaurant = restaurant
        }
    }
    
    // XX的退出功能
    @IBAction func close(segue:UIStoryboardSegue){
        dismiss(animated: true, completion: nil)
    }
    
    // 評價表情地退出功能
    @IBAction func rateResaurant(segue:UIStoryboardSegue){
        if let rating = segue.identifier{
            self.restaurant.rating = rating
            self.headerView.ratingImageView.image = UIImage(named:rating)
            
            let scaleTransform = CGAffineTransform.init(scaleX:0.1,y:0.1)
            self.headerView.ratingImageView.transform = scaleTransform
            self.headerView.ratingImageView.alpha = 0
            
            UIView.animate(withDuration: 0.4,delay:0.4,usingSpringWithDamping:0.2,initialSpringVelocity:0.7,options:[], animations: {
                self.headerView.ratingImageView.transform = .identity
                self.headerView.ratingImageView.alpha = 1
            })
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
//    由於viewDidLoad只會讀取一次，故使用viewWillAppear，每次呈現畫面前，去調整導覽列顯示問題
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated:true)
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //連結DataSource Delegate
        tableView.delegate = self
        tableView.dataSource = self
        // 控制是否位移，這個案例中，為了將整個table往上移，故選never
        // automatic 和scrollableAxes一样,scrollView会自动计算和适应顶部和底部的内边距并且在scrollView 不可滚动时,也会设置内边距.
//        scrollableAxes 自动计算内边距.
//        never不计算内边距
//        always 根据safeAreaInsets 计算内边距
//
//        作者：codeCoder
//        链接：https://www.jianshu.com/p/1601bd885f83
//        來源：简书
//        著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
        tableView.contentInsetAdjustmentBehavior = .never
        // 移除cell的格線
        tableView.separatorStyle = .none

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
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        // 導覽列的顏色
        navigationController?.navigationBar.tintColor = .white
        navigationController?.hidesBarsOnSwipe = false
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
        return 5
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
        case 3 :
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:RestaurantDetailSeparatorCell.self), for: indexPath) as! RestaurantDetailSeparatorCell
            cell.titelLabel.text = "How to get here"
            
            return cell
        case 4 :
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:RestaurantDetailMapCell.self), for: indexPath) as! RestaurantDetailMapCell
            cell.configure(location: restaurant.location)
            
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
