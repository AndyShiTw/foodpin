//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by HSU JUI-FU on 2018/2/7.
//  Copyright © 2018年 AndyShi. All rights reserved.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    var restaurantNames = ["Cafe Deadend","Homei","Teakha","Cafe Loisl","Petite Oyster","For Kee Restaurant","Po's Atelier","Bourke Street Bakery","Haigh's Chocolate","Palomino Espresso","Upstate","Traif","Graham Avenue Meats and Deli","Waffie & Wolf","Five Leaves","Cafe Lore","Confessional","Barrafina","Donostia","Royal Oak","CASK Pub and Kitchen"];
    var restaurantImage = [#imageLiteral(resourceName: "cafedeadend"),#imageLiteral(resourceName: "homei"),#imageLiteral(resourceName: "teakha"),#imageLiteral(resourceName: "cafeloisl"),#imageLiteral(resourceName: "petiteoyster"),#imageLiteral(resourceName: "forkeerestaurant"),#imageLiteral(resourceName: "posatelier"),#imageLiteral(resourceName: "bourkestreetbakery"),#imageLiteral(resourceName: "haighschocolate"),#imageLiteral(resourceName: "palominoespresso"),#imageLiteral(resourceName: "upstate"),#imageLiteral(resourceName: "traif"),#imageLiteral(resourceName: "grahamavenuemeats"),#imageLiteral(resourceName: "wafflewolf"),#imageLiteral(resourceName: "fiveleaves"),#imageLiteral(resourceName: "cafelore"),#imageLiteral(resourceName: "confessional"),#imageLiteral(resourceName: "barrafina"),#imageLiteral(resourceName: "donostia"),#imageLiteral(resourceName: "royaloak"),#imageLiteral(resourceName: "caskpubkitchen")]
    var restaurantImage2 = ["cafedeadend","homei"];
    var restaurantLocation = ["Hong Konk","Hong Konk","Hong Konk","Hong Konk","Hong Konk","Hong Konk","Hong Konk","Sydney","Sydney","Sydney","New York","New York","New York","New York","New York","New York","New York","London","London","London","London"];
    var restaurantType = ["Coffee & Tea Shop","Cafe","Tea House","Austrain / Causual Drink","French","Bakery","Bakery","Chocolate","Cafe","American / Seafood","American","American","Breakfast & Brunch","Coffee & Tea","Latin American","Spanish","Spanish","Spanish","Spanish","British","Thai"];
    var restaurantIsVisited = Array(repeating: false, count: 21)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.cellLayoutMarginsFollowReadableWidth = true;

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantNames.count;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let optionMenu = UIAlertController(title:nil,message:"what do you want?",preferredStyle:.actionSheet)
        
        // iPad不使用actionSheet，使用popoverCotnroller處理
        if let popoverController = optionMenu.popoverPresentationController{
            if let cell = tableView.cellForRow(at: indexPath){
                popoverController.sourceView = cell;
                popoverController.sourceRect = cell.bounds;
            }
        }
        
        let cancelAction = UIAlertAction(title:"Cancel",style:.cancel,handler:nil)
        
        optionMenu.addAction(cancelAction)
        
        let callActionHandler = { (action:UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title:"Service Unavailable" , message:"Sorry",preferredStyle:.alert);
        alertMessage.addAction(UIAlertAction(title:"OK",style:.default,handler:nil))
            self.present(alertMessage,animated: true,completion: nil);
        }
        let callAction = UIAlertAction(title:"Call 123-000-\(indexPath.row)" , style:.default,handler:callActionHandler )
        optionMenu.addAction(callAction)
        
        let checkInAction = UIAlertAction(title: "Check in", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            
            let hearttick = UIImage(named:"heart-tick");
            let imageView = UIImageView(image:hearttick);
            // 這裡的cell是在點選時，就加上打勾標記
            let cell = tableView.cellForRow(at: indexPath)
            //cell?.accessoryType = .checkmark
            cell?.accessoryView = imageView;
            // 這個陣列是為了讓view 也就是cellForRowAt去判斷，這個cell需不需要打勾
            self.restaurantIsVisited[indexPath.row] = true
        })
        
        //取消勾選功能
        let undoCheckInAction = UIAlertAction(title: "Undo Check in", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            
            // 這裡的cell是在點選時，就取消打勾標記
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .none
            // 這個陣列是為了讓view 也就是cellForRowAt去判斷，這個cell需不需要打勾
            self.restaurantIsVisited[indexPath.row] = false
        })

        // 若已勾選的選項，顯示取消勾選功能
        if(restaurantIsVisited[indexPath.row]){
            optionMenu.addAction(undoCheckInAction)
        } else {
            optionMenu.addAction(checkInAction)
        }

        present(optionMenu,animated:true,completion:nil)
        
        // 取消選取行數灰底
        tableView.deselectRow(at: indexPath, animated: false)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell";
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
        let hearttick = UIImage(named:"heart-tick");
        let imageView = UIImageView(image:hearttick);
        
        
        cell.nameLabel?.text = restaurantNames[indexPath.row];
        cell.thumbnailImageView?.image = restaurantImage[indexPath.row];
        cell.locationLabel?.text = restaurantLocation[indexPath.row];
        cell.typeLabel?.text = restaurantType[indexPath.row];
        if(restaurantIsVisited[indexPath.row]){
            //cell.accessoryType = .checkmark
            cell.accessoryView = imageView;
        } else {
            cell.accessoryType = .none
        }
        
        // 我故意將restaurantImage2陣列只有一個值
//        if(restaurantImage2.count > indexPath.row){
//            cell.imageView?.image = UIImage(named:restaurantImage2[indexPath.row]);
//        }

        return cell
    }
    
    // Override to support editing the table view.
    // 用來新增或刪除tableview
    /*
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            restaurantNames.remove(at: indexPath.row)
            restaurantLocation.remove(at: indexPath.row)
            restaurantType.remove(at: indexPath.row)
            restaurantIsVisited.remove(at: indexPath.row)
            restaurantImage.remove(at: indexPath.row)
            
            // 直接從畫面上刪除，並使用動畫功能
            tableView.deleteRows(at: [indexPath], with: .left)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        
        // 畫面重新讀取資料
//        tableView.reloadData()
        
        //debug方法
        print("total item \(restaurantNames.count)")
        for name in restaurantNames{
            print(name)
        }
    }
    */
    
    override func tableView(_ tableView:UITableView,trailingSwipeActionsConfigurationForRowAt indexPath:IndexPath) -> UISwipeActionsConfiguration? {
        let  deleteAction = UIContextualAction(style:.destructive,title:"Delete"){ (action,sourceView,completionHandler) in
            // 找到資料來源並刪除
            self.restaurantNames.remove(at: indexPath.row)
            self.restaurantLocation.remove(at: indexPath.row)
            self.restaurantType.remove(at: indexPath.row)
            self.restaurantIsVisited.remove(at: indexPath.row)
            self.restaurantImage.remove(at: indexPath.row)
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            // 呼叫完成處理器取消動作按鈕
            completionHandler(true);
        }
        
        let  shareAction = UIContextualAction(style:.normal,title:"Share"){ (action,sourceView,completionHandler) in
            let defaultText = " Just checking in at  " + self.restaurantNames[indexPath.row];
            let activityController = UIActivityViewController(activityItems:[defaultText],applicationActivities:nil)
            self.present(activityController,animated:true,completion:nil )

            
            // 呼叫完成處理器取消動作按鈕
            completionHandler(true);
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions:[deleteAction,shareAction])
        
        return swipeConfiguration
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
