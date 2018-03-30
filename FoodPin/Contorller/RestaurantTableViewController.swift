//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by HSU JUI-FU on 2018/2/7.
//  Copyright © 2018年 AndyShi. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController,NSFetchedResultsControllerDelegate,UISearchResultsUpdating {
    
    // 更新搜尋畫面
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
    
    // 使用Class處理資料
    var restaurants: [RestaurantMO] = [];
    // 利用coredata處理資料
    var fetchResultController: NSFetchedResultsController<RestaurantMO>!
    // 搜尋列
    var searchController: UISearchController!
    var searchResults : [RestaurantMO] = []
    
    // 新增餐廳的回到上一頁功能
    @IBAction func unwindToHome(Segue:UIStoryboardSegue){
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet var emptyRestaurantView : UIView!
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        // 搜尋segue的ID，並將資料傳遞過去
        if segue.identifier == "showRestaurantDetail"{
            if let indexPath = tableView.indexPathForSelectedRow{
                let destinationController = segue.destination as! RestaurantDetailViewController
                destinationController.restaurant = (searchController.isActive) ? searchResults[indexPath.row] : restaurants[indexPath.row]
            }
        }
        
    }
    //    由於viewDidLoad只會讀取一次，故使用viewWillAppear，每次呈現畫面前，去調整導覽列顯示問題
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true
    }
    
    // 過濾搜尋結果
    func filterContent(for searchText:String){
        searchResults = restaurants.filter({ (restaurant) -> Bool in
            var isMatch = false
            
            if let name = restaurant.name {
                isMatch = name.localizedCaseInsensitiveContains(searchText)
            }
            if let location = restaurant.location {
                isMatch = location.localizedCaseInsensitiveContains(searchText)
            }
            
            return isMatch
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.cellLayoutMarginsFollowReadableWidth = true;
        
        // 處理搜尋列
        searchController = UISearchController(searchResultsController:nil)
        //self.navigationItem.searchController = searchController
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
        // 開啟大標題
        navigationController?.navigationBar.prefersLargeTitles = true;

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//        取消導覽列標題
        navigationController?.hidesBarsOnSwipe = true
        
       
        // 將導覽列插入一個空白圖片，以表現透明
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        // 改變標題顏色
        if let customFonr = UIFont(name:"Rubik-Medium",size:40.0){
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor(red:231.0/255.0,green:76.0/255.0,blue:60.0/255.0,alpha:1.0),NSAttributedStringKey.font:customFonr]
        }
        
        // 沒有資料的時候，顯示empty圖片
        tableView.backgroundView = emptyRestaurantView
        tableView.backgroundView?.isHidden = true
        
        // 從coredata讀取資料
        let fetchRequest: NSFetchRequest<RestaurantMO> = RestaurantMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key:"name",ascending:true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest:fetchRequest,managedObjectContext:context,sectionNameKeyPath:nil,cacheName:nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                if let fetchObjects = fetchResultController.fetchedObjects{
                    restaurants = fetchObjects
                }
            } catch{
                print(error)
            }
        }
        
    }
    
    // coredata相關
    // 告知tableview準備要更新table cell
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    // 當有資料被儲存，會呼叫這個function，依照對應的CRUD呼叫
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = newIndexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = newIndexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        
        if let fetchedObjects = controller.fetchedObjects{
            restaurants = fetchedObjects as! [RestaurantMO]
        }
    }
    
    // 當NSFetchedResultsController完成時，告知這個func去更新表格
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if restaurants.count > 0 {
            tableView.backgroundView?.isHidden = true;
            tableView.separatorStyle = .singleLine
        } else {
            tableView.backgroundView?.isHidden = false;
            tableView.separatorStyle = .none

        }
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 根據是否啟動搜尋模式，回傳對應的資料
        if searchController.isActive {
            return searchResults.count
        } else {
            return restaurants.count
        }
    }
    
    // 點選cell彈出下方選單
    /*
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
            cell?.accessoryView = .none
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
    */

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell";
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
        let hearttick = UIImage(named:"heart-tick");
        let imageView = UIImageView(image:hearttick);
        let restaurant = (searchController.isActive) ? searchResults[indexPath.row] : restaurants[indexPath.row]
        
        cell.nameLabel?.text = restaurant.name;
        if let restaurantImage = restaurant.image{
            cell.thumbnailImageView?.image = UIImage(data: restaurantImage as Data);
        }
        cell.locationLabel?.text = restaurant.location;
        cell.typeLabel?.text = restaurant.type;
        if(restaurant.isVisited){
            cell.accessoryType = .checkmark
            cell.accessoryView = imageView;
        } else {
            cell.accessoryType = .none
            cell.accessoryView = .none;
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
        let deleteAction = UIContextualAction(style:.destructive,title:"Delete"){ (action,sourceView,completionHandler) in
            // 找到資料來源並刪除
            //self.restaurants.remove(at: indexPath.row)
            
            //self.tableView.deleteRows(at: [indexPath], with: .fade)
            
            // 刪除coredata的資料
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
                // 刪除資料時要使用tableView.beginUpdates，告知tableview要異動，否則會出現錯誤
                tableView.beginUpdates()
                
                let context = appDelegate.persistentContainer.viewContext
                let restaurantToDelete = self.fetchResultController.object(at: indexPath)
                context.delete(restaurantToDelete)
                appDelegate.saveContext()
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                tableView.endUpdates()
            }

            // 呼叫完成處理器取消動作按鈕
            completionHandler(true);
        }
        
        let shareAction = UIContextualAction(style:.normal,title:"Share"){ (action,sourceView,completionHandler) in
            let defaultText = " Just checking in at  " + self.restaurants[indexPath.row].name!
            let activityController : UIActivityViewController
            
            if let restaurantImage = self.restaurants[indexPath.row].image,let imageToShare : UIImage = UIImage(data:restaurantImage as Data){
                activityController = UIActivityViewController(activityItems:[defaultText,imageToShare],applicationActivities:nil)
            } else {
                activityController = UIActivityViewController(activityItems:[defaultText],applicationActivities:nil)
            }
            
            if let popoverController = activityController.popoverPresentationController{
                if let cell = tableView.cellForRow(at: indexPath){
                    popoverController.sourceView = cell;
                    popoverController.sourceRect = cell.bounds;
                }
            }
            
            self.present(activityController,animated:true,completion:nil )
            
            // 呼叫完成處理器取消動作按鈕
            completionHandler(true);
        }
        
        deleteAction.image = UIImage(named:"delete");
        deleteAction.backgroundColor = UIColor(red:231.0/255.0,green:76.0/255.0,blue:38.0/255.0,alpha:1.0)
        
        shareAction.image = UIImage(named:"share");
        shareAction.backgroundColor = UIColor(red:254.0/255.0,green:149.0/255.0,blue:18.0/255.0,alpha:1.0)
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions:[deleteAction,shareAction])
        
        return swipeConfiguration
    }
    
    override func tableView(_ tableView:UITableView,leadingSwipeActionsConfigurationForRowAt indexPath:IndexPath) -> UISwipeActionsConfiguration? {
        let checkinAction = UIContextualAction(style:.normal,title:"Share"){ (action,sourceView,completionHandler) in
            let hearttick = UIImage(named:"heart-tick");
            let imageView = UIImageView(image:hearttick);
            
            // 這裡的cell是在點選時，就加上打勾標記
            let cell = tableView.cellForRow(at: indexPath)
            //cell?.accessoryType = .checkmark
            cell?.accessoryView = imageView;
            // 這個陣列是為了讓view 也就是cellForRowAt去判斷，這個cell需不需要打勾
            self.restaurants[indexPath.row].isVisited = true
            
            // 呼叫完成處理器取消動作按鈕
            completionHandler(true);
        }
        
        let undoAction = UIContextualAction(style:.normal,title:"Share"){ (action,sourceView,completionHandler) in
            // 這裡的cell是在點選時，就取消打勾標記
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .none
            cell?.accessoryView = .none
            // 這個陣列是為了讓view 也就是cellForRowAt去判斷，這個cell需不需要打勾
            self.restaurants[indexPath.row].isVisited = false
            
            // 呼叫完成處理器取消動作按鈕
            completionHandler(true);
        }
        
        //checkinAction = UIColor(red:231.0/255.0,green:76.0/255.0,blue:38.0/255.0,alpha:1.0)
        //undoAction = UIColor(red:254.0/255.0,green:149.0/255.0,blue:18.0/255.0,alpha:1.0)
        checkinAction.image = UIImage(named:"tick");
        undoAction.image = UIImage(named:"undo");
        checkinAction.backgroundColor = UIColor(red:124/255,green:252/255,blue:0/255,alpha:1);
        undoAction.backgroundColor = UIColor(red:34/255,green:128/255,blue:34/255,alpha:1);
        
        let swipeConfiguration:UISwipeActionsConfiguration;
        
        if(restaurants[indexPath.row].isVisited){
            swipeConfiguration = UISwipeActionsConfiguration(actions:[undoAction])
        } else {
            swipeConfiguration = UISwipeActionsConfiguration(actions:[checkinAction])
        }
        
        return swipeConfiguration
    }
    
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        // 搜尋功能啟動時，停止編輯
        if searchController.isActive {
            return false
        } else {
            return true
        }
    }
 

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

    
    

}
