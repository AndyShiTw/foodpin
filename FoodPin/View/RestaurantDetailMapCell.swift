//
//  RestaurantDetailMapCell.swift
//  FoodPin
//
//  Created by HSU JUI-FU on 2018/3/1.
//  Copyright © 2018年 AndyShi. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailMapCell: UITableViewCell {

    @IBOutlet var mapView: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(location:String){
        // 取得位置
        let geoCoder = CLGeocoder()
        
        print(location)
        
        geoCoder.geocodeAddressString(location, completionHandler: { placemarks, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let placemarks = placemarks {
                print("123456");
                // 取得第一個地點標記
                let placemark = placemarks[0]
                
                // 加上標記
                let annotaion = MKPointAnnotation()
                
                if let location = placemark.location {
                    // 顯示標記
                    annotaion.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotaion)
                    
                    // 設定縮放程度
                    let region = MKCoordinateRegionMakeWithDistance(annotaion.coordinate, 250, 250)
                    self.mapView.setRegion(region, animated: false)
                    
                }
            }
        })
    }
}
