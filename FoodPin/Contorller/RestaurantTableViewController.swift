//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by HSU JUI-FU on 2018/2/7.
//  Copyright © 2018年 AndyShi. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController,NSFetchedResultsControllerDelegate {
    /*
    var restaurantNames = ["Cafe Deadend","Homei","Teakha","Cafe Loisl","Petite Oyster","For Kee Restaurant","Po's Atelier","Bourke Street Bakery","Haigh's Chocolate","Palomino Espresso","Upstate","Traif","Graham Avenue Meats and Deli","Waffie & Wolf","Five Leaves","Cafe Lore","Confessional","Barrafina","Donostia","Royal Oak","CASK Pub and Kitchen"];
    var restaurantImage = [#imageLiteral(resourceName: "cafedeadend"),#imageLiteral(resourceName: "homei"),#imageLiteral(resourceName: "teakha"),#imageLiteral(resourceName: "cafeloisl"),#imageLiteral(resourceName: "petiteoyster"),#imageLiteral(resourceName: "forkeerestaurant"),#imageLiteral(resourceName: "posatelier"),#imageLiteral(resourceName: "bourkestreetbakery"),#imageLiteral(resourceName: "haighschocolate"),#imageLiteral(resourceName: "palominoespresso"),#imageLiteral(resourceName: "upstate"),#imageLiteral(resourceName: "traif"),#imageLiteral(resourceName: "grahamavenuemeats"),#imageLiteral(resourceName: "wafflewolf"),#imageLiteral(resourceName: "fiveleaves"),#imageLiteral(resourceName: "cafelore"),#imageLiteral(resourceName: "confessional"),#imageLiteral(resourceName: "barrafina"),#imageLiteral(resourceName: "donostia"),#imageLiteral(resourceName: "royaloak"),#imageLiteral(resourceName: "caskpubkitchen")]
    var restaurantImage2 = ["cafedeadend","homei"];
    var restaurantLocation = ["Hong Konk","Hong Konk","Hong Konk","Hong Konk","Hong Konk","Hong Konk","Hong Konk","Sydney","Sydney","Sydney","New York","New York","New York","New York","New York","New York","New York","London","London","London","London"];
    var restaurantType = ["Coffee & Tea Shop","Cafe","Tea House","Austrain / Causual Drink","French","Bakery","Bakery","Chocolate","Cafe","American / Seafood","American","American","Breakfast & Brunch","Coffee & Tea","Latin American","Spanish","Spanish","Spanish","Spanish","British","Thai"];
    var restaurantIsVisited = Array(repeating: false, count: 21)
    */
    
    // 使用Class處理資料
    var restaurants: [RestaurantMO] = [];
    var fetchResultController: NSFetchedResultsController<RestaurantMO>!
//    var restaurants:[Restaurant] = [
//        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong", phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "cafedeadend", isVisited: false),
//        Restaurant(name: "Homei", type: "Cafe", location: "Shop B, G/F, 22-24A Tai Ping San Street SOHO, Sheung Wan, Hong Kong", phone: "348-233423", description: "A little gem hidden at the corner of the street is nothing but fantastic! This place is warm and cozy. We open at 7 every morning except Sunday, and close at 9 PM. We offer a variety of coffee drinks and specialties including lattes, cappuccinos, teas, and more. We serve breakfast, lunch, and dinner in an airy open setting. Come over, have a coffee and enjoy a chit-chat with our baristas.", image: "homei.jpg", isVisited: false),
//        Restaurant(name: "Teakha", type: "Tea House", location: "Shop B, 18 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", phone: "354-243523", description: "Take a moment to stop and smell tealeaves! We are about the community, our environment, and all things created by the warmth of our hands. We open at 11 AM, and close at 7 PM. At teakha, we sell only the best single-origin teas sourced by our sister company Plantation directly from small tea plantations. The teas are then either cooked to perfection with milk in a pot or brewed.", image: "teakha.jpg", isVisited: false),
//        Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Shop B, 20 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", phone: "453-333423", description: "A great cafe in Austrian style. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. We also serve breakfast and light lunch. Come over to enjoy the elegant ambience and quality coffee..", image: "cafeloisl.jpg", isVisited: false),
//        Restaurant(name: "Petite Oyster", type: "French", location: "24 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", phone: "983-284334", description: "An upscale dining venue, features premium and seasonal imported oysters, and delicate yet creative modern European cuisines. Its oyster bar displays a full array of freshest oysters imported from all over the world including France, Australia, USA and Japan.", image: "petiteoyster.jpg", isVisited: false),
//        Restaurant(name: "For Kee Restaurant", type: "Hong Kong", location: "Shop J-K., 200 Hollywood Road, SOHO, Sheung Wan, Hong Kong", phone: "232-434222", description: "A great local cafe for breakfast and lunch! Located in a quiet area in Sheung Wan, we offer pork chop buns, HK french toast, and many more. We open from 7 AM to 4:30 PM.", image: "forkeerestaurant.jpg", isVisited: false),
//        Restaurant(name: "Po's Atelier", type: "Bakery", location: "G/F, 62 Po Hing Fong, Sheung Wan, Hong Kong", phone: "234-834322", description: "A boutique bakery focusing on artisan breads and pastries paired with inspiration from Japan and Scandinavia. We are crazy about bread and excited to share our artisan bakes with you. We open at 10 every morning, and close at 7 PM.", image: "posatelier.jpg", isVisited: false),
//        Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "633 Bourke St Sydney New South Wales 2010 Surry Hills", phone: "982-434343", description: "We make everything by hand with the best possible ingredients, from organic sourdoughs to pastries and cakes. A combination of great produce, good strong coffee, artisanal skill and hard work creates the honest, soulful, delectable bites that have made Bourke Street Bakery famous. Visit us at one of our many Sydney locations!", image: "bourkestreetbakery.jpg", isVisited: false),
//        Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "412-414 George St Sydney New South Wales", phone: "734-232323", description: "Haigh's Chocolates is Australia's oldest family owned chocolate maker. We have been making chocolate in Adelaide, South Australia since 1915 and we are committed to the art of premium chocolate making from the cocoa bean. Our chocolates are always presented to perfection in our own retail stores. Visit any one of them and you'll find chocolate tasting, gift wrapping and personalised attention are all part of the service.", image: "haighschocolate.jpg", isVisited: false),
//        Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Shop 1 61 York St Sydney New South Wales", phone: "872-734343", description: "We offer an assortment of on-site baked goods and sandwiches. This place has always been a favourite among office workers. We open at 7 every morning including Sunday, and close at 4 PM. Come over, have a coffee and enjoy a chit-chat with our baristas.", image: "palominoespresso.jpg", isVisited: false),
//        Restaurant(name: "Upstate", type: "Seafood", location: "95 1st Ave New York, NY 10003", phone: "343-233221", description: "The absolute best seafood place in town. The atmosphere here creates a very homey feeling. We open at 5 PM, and close at 10:30 PM. ", image: "upstate.jpg", isVisited: false),
//        Restaurant(name: "Traif", type: "American", location: "229 S 4th St Brooklyn, NY 11211", phone: "985-723623", description: "A young crowd populates this pork-focused American eatery in an older Williamsburg neighborhood. We open at 6PM, and close at 11 PM. If you enjoy a shared small plates dinner experience, come over and have a try.", image: "traif.jpg", isVisited: false),
//        Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "445 Graham Ave Brooklyn, NY 11211", phone: "455-232345", description: "Classic Italian deli & butcher draws patrons with meat-filled submarine sandwiches. We use the freshest meats and veggies to create the perfect panini for you. We look forward to seeing you!", image: "grahamavenuemeats.jpg", isVisited: false),
//        Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "413 Graham Ave Brooklyn, NY 11211", phone: "434-232322", description: "Small shop, some seating, definitely something different! We open at 7 every morning except Sunday, and close at 9 PM. We offer a variety of waffles with choices of sweet & savory fillings. If you are gluten free and craving waffles, this is the place to go.", image: "wafflewolf.jpg", isVisited: false),
//        Restaurant(name: "Five Leaves", type: "Bistro", location: "18 Bedford Ave Brooklyn, NY 11222", phone: "343-234553", description: " Great food, cocktails, ambiance, service. Nothing beats having a warm dinner and a whiskey. We open at 8 every morning, and close at 1 AM. The ricotta pancakes are something you must try.", image: "fiveleaves.jpg", isVisited: false),
//        Restaurant(name: "Cafe Lore", type: "Latin American", location: "Sunset Park 4601 4th Ave Brooklyn, NY 11220", phone: "342-455433", description: "Good place, great environment and amazing food! We open at 10 every morning except Sunday, and close at 9 PM. Give us a visit! Enjoy mushroom raviolis, pumpkin raviolis, meat raviolis with sausage and peppers, pork cutlets, eggplant parmesan, and salad.", image: "cafelore.jpg", isVisited: false),
//        Restaurant(name: "Confessional", type: "Spanish", location: "308 E 6th St New York, NY 10003", phone: "643-332323", description: "Most delicious cocktail you would ever try! Our menu includes a wide range of high quality internationally inspired dishes, vegetarian options, and local cuisine. We open at 10 AM, and close at 10 PM. We welcome you into our place to enjoy a meal with your friends.", image: "confessional.jpg", isVisited: false),
//        Restaurant(name: "Barrafina", type: "Spanish", location: "54 Frith Street London W1D 4SL United Kingdom", phone: "542-343434", description: "a collection of authentic Spanish Tapas bars in Central London! We have an open kitchen, a beautiful marble-topped bar where guests can sit and watch the chefs at work and stylish red leather stools. Lunch starts at 1 PM. Dinners starts 5:30 PM.", image: "barrafina.jpg", isVisited: false),
//        Restaurant(name: "Donostia", type: "Spanish", location: "10 Seymour Place London W1H 7ND United Kingdom", phone: "722-232323", description: "Very good basque food, creative dishes with terrific flavors! Donostia is a high end tapas restaurant with a friendly relaxed ambiance. Come over to enjoy awesome tapas!", image: "donostia.jpg", isVisited: false),
//        Restaurant(name: "Royal Oak", type: "British", location: "2 Regency Street London SW1P 4BZ United Kingdom", phone: "343-988834", description: "Specialise in great pub food. Established in 1872, we have local and world lagers, craft beer and a selection of wine and spirits for people to enjoy. Don't forget to try our range of Young's Ales and Fish and Chips.", image: "royaloak.jpg", isVisited: false),
//        Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "22 Charlwood Street London SW1V 2DY Pimlico", phone: "432-344050", description: "With kitchen serving gourmet burgers. We offer food every day of the week, Monday through to Sunday. Join us every Sunday from 4:30 – 7:30pm for live acoustic music!", image: "caskpubkitchen.jpg", isVisited: false)
//    ]
    
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
                destinationController.restaurant = restaurants[indexPath.row]
            }
        }
        
    }
    //    由於viewDidLoad只會讀取一次，故使用viewWillAppear，每次呈現畫面前，去調整導覽列顯示問題
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.cellLayoutMarginsFollowReadableWidth = true;
        
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
        return restaurants.count;
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
        
        
        cell.nameLabel?.text = restaurants[indexPath.row].name;
        if let restaurantImage = restaurants[indexPath.row].image{
            cell.thumbnailImageView?.image = UIImage(data: restaurantImage as Data);
        }
        cell.locationLabel?.text = restaurants[indexPath.row].location;
        cell.typeLabel?.text = restaurants[indexPath.row].type;
        if(restaurants[indexPath.row].isVisited){
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

    
    

}
