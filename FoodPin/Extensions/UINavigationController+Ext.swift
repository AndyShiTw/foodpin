//
//  UINavigationController+Ext.swift
//  FoodPin
//
//  Created by HSU JUI-FU on 2018/2/28.
//  Copyright © 2018年 AndyShi. All rights reserved.
//

import UIKit

extension UINavigationController {
    open override var childViewControllerForStatusBarStyle : UIViewController?{
        return topViewController
    }
}
