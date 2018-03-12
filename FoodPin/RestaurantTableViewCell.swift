//
//  RestaurantTableViewCell.swift
//  FoodPin
//
//  Created by HSU JUI-FU on 2018/2/8.
//  Copyright © 2018年 AndyShi. All rights reserved.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel : UILabel!
    @IBOutlet var locationLabel : UILabel!
    @IBOutlet var typeLabel : UILabel!
    @IBOutlet var thumbnailImageView : UIImageView! {
        didSet {
            //thumbnailImageView.layer.cornerRadius = thumbnailImageView.bounds.width / 3
            //thumbnailImageView.clipsToBounds = true
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
