//
//  RoundedTextField.swift
//  FoodPin
//
//  Created by HSU JUI-FU on 2018/3/13.
//  Copyright © 2018年 AndyShi. All rights reserved.
//

import UIKit

class RoundedTextField: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    // 調整縮排
    let padding = UIEdgeInsets(top:0,left:10,bottom:0,right:10)
    
    // 調整文字的縮排
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    // 調整預設輸入文字的的縮排
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    // 調整調整可編輯文字的縮排
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    // 建立圓角
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
    }
}
