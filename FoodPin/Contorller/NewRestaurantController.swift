//
//  NewRestaurantController.swift
//  FoodPin
//
//  Created by HSU JUI-FU on 2018/3/13.
//  Copyright © 2018年 AndyShi. All rights reserved.
//

import UIKit
import CoreData

// UIImagePickerControllerDelegate,UINavigationControllerDelegate 是用來取得照片的

class NewRestaurantController: UITableViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var restaurant: RestaurantMO!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        // 設定導覽列外觀
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        if let customFont = UIFont(name:"Rubik-Medium",size:35.0){
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor(red:231,green:76,blue:60),NSAttributedStringKey.font:customFont]
        }
        
    }
    
    @IBAction func saveButtonTapped(){
        print("name:"+nameTextField.text!)
        print("type:"+typeTextField.text!)
        print("phone"+phoneTextField.text!)
        print("location:"+addressTextField.text!)
        print("description:"+descriptionTextView.text!)
        
        var vaildMessage = "";
        
        if nameTextField.text == ""{
            vaildMessage += "請輸入名稱\n"
        }
        if typeTextField.text == ""{
            vaildMessage += "請輸入類型\n"
        }
        if phoneTextField.text == ""{
            vaildMessage += "請輸入電話\n"
        }
        if addressTextField.text == ""{
            vaildMessage += "請輸入地址\n"
        }
        if descriptionTextView.text == ""{
            vaildMessage += "請輸入解釋\n"
        }
        
        let vaildAlertController = UIAlertController(title:"",message:vaildMessage,preferredStyle:.alert)
        let cancelAction = UIAlertAction(title:"確認",style:.cancel,handler:nil)
        
        if vaildMessage.count > 0 {
            vaildAlertController.addAction(cancelAction);
            present(vaildAlertController,animated: true,completion: nil)
        } else {
            // 儲存資料
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate){
                restaurant = RestaurantMO(context : appDelegate.persistentContainer.viewContext)
                restaurant.name = nameTextField.text
                restaurant.phone = phoneTextField.text
                restaurant.type = typeTextField.text
                restaurant.location = addressTextField.text
                restaurant.summary = descriptionTextView.text
                restaurant.isVisited = false
                
                if let restaurantImage = photoImageView.image  {
                    // 使用UIImagePNGRepresentation會導致照片轉90度，使用JPEG就不會有這個問題
                    restaurant.image = UIImageJPEGRepresentation(restaurantImage,1.0)
                }
                
                appDelegate.saveContext()
            }
            
            
            
            performSegue(withIdentifier: "unwinToHome", sender: self)
        }
    }
    
    @IBOutlet var photoImageView : UIImageView!
    
    // 為了讓return可以跳到下一格，設定tag編號
    @IBOutlet var nameTextField : RoundedTextField! {
        didSet{
            nameTextField.tag = 1
            nameTextField.becomeFirstResponder()
            nameTextField.delegate = self
        }
    }
    
    @IBOutlet var typeTextField : RoundedTextField! {
        didSet{
            typeTextField.tag = 3
            typeTextField.delegate = self
        }
    }
    
    @IBOutlet var addressTextField : RoundedTextField! {
        didSet{
            addressTextField.tag = 4
            addressTextField.delegate = self
        }
    }
    
    @IBOutlet var phoneTextField : RoundedTextField! {
        didSet{
            phoneTextField.tag = 2
            phoneTextField.delegate = self
        }
    }
    
    @IBOutlet var descriptionTextView: UITextView! {
        didSet {
            descriptionTextView.tag = 5
            descriptionTextView.layer.cornerRadius = 5.0
            descriptionTextView.layer.masksToBounds = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag+1){
            // 移除foucs再目前的textField
            textField.resignFirstResponder()
            // foucs再下一個textField
            nextTextField.becomeFirstResponder()
        }
        
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 實作這個方法，從參數取得圖片
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // info[UIImagePickerControllerOriginalImage]是選取的圖片
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
        
        //設定約束條件，從照片的左邊到整個畫面的最左邊
        let leadingConstraint = NSLayoutConstraint(item:photoImageView,attribute:.leading,relatedBy:.equal,toItem:photoImageView.superview,attribute:.leading,multiplier:1,constant:0)
        leadingConstraint.isActive = true
        
        //設定約束條件，從照片的右邊到整個畫面的最右
        let trailingConstraint = NSLayoutConstraint(item:photoImageView,attribute:.trailing,relatedBy:.equal,toItem:photoImageView.superview,attribute:.trailing,multiplier:1,constant:0)
        trailingConstraint.isActive = true
        
        //設定約束條件，從照片的上面到整個畫面的最上面
        let topConstraint = NSLayoutConstraint(item:photoImageView,attribute:.top,relatedBy:.equal,toItem:photoImageView.superview,attribute:.top,multiplier:1,constant:0)
        topConstraint.isActive = true
        
        //設定約束條件，從照片的上面到整個畫面的最上面
        let bottomConstraint = NSLayoutConstraint(item:photoImageView,attribute:.bottom,relatedBy:.equal,toItem:photoImageView.superview,attribute:.bottom,multiplier:1,constant:0)
        bottomConstraint.isActive = true
        
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let photoSourceRequestController = UIAlertController(title:"",message:"choose your photo source",preferredStyle:.actionSheet)
            
            let cameraAction = UIAlertAction(title:"Camera",style:.default,handler:{
                (action) in
                if UIImagePickerController.isSourceTypeAvailable(.camera){
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .camera
                    imagePicker.delegate = self
                    self.present(imagePicker,animated: true,completion: nil)
                }
            })
            
            let photoLibrayAction = UIAlertAction(title:"Photo libray",style:.default,handler:{
                (action) in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                    let imagePicker = UIImagePickerController()
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    imagePicker.delegate = self
                    self.present(imagePicker,animated: true,completion: nil)
                }
            })
            
            photoSourceRequestController.addAction(cameraAction)
            photoSourceRequestController.addAction(photoLibrayAction)
            let cancelAction = UIAlertAction(title:"取消",style:.cancel,handler:nil)
            photoSourceRequestController.addAction(cancelAction)
            
            present(photoSourceRequestController,animated: true,completion: nil)
            
            
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    
}
