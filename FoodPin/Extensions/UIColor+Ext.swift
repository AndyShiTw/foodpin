//
//  UIColor+Ext.swift
//  FoodPin
//
//  Created by HSU JUI-FU on 2018/2/28.
//  Copyright © 2018年 AndyShi. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red:Int,green:Int,blue:Int){
        let redValue = CGFloat(red)/255.0
        let greenValue = CGFloat(red)/255.0
        let blueValue = CGFloat(red)/255.0
        self.init(red:redValue,green:greenValue,blue:blueValue,alpha:1.0)
    }
}
