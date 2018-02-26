//
//  Restaurant.swift
//  FoodPin
//
//  Created by HSU JUI-FU on 2018/2/26.
//  Copyright © 2018年 AndyShi. All rights reserved.
//

import Foundation
import UIKit

class Restaurant {
    var name : String
    var type : String
    var location : String
    var image : String
    var isVisited : Bool
    var phone : String;
    var description : String;
    
    init(name:String,type:String,location:String,image:String,isVisited:Bool,phone:String,description:String){
        self.name = name
        self.type = type
        self.location = location
        self.image = image
        self.isVisited = isVisited
        self.phone = phone
        self.description = description
    }
    
    convenience init() {
        self.init(name:"",type:"",location:"",image:"",isVisited:false,phone:"",description:"")
    }
    
    
}
