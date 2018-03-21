//
//  MapViewController.swift
//  FoodPin
//
//  Created by HSU JUI-FU on 2018/3/1.
//  Copyright © 2018年 AndyShi. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController , MKMapViewDelegate {
    @IBOutlet var mapView : MKMapView!
    
    var restaurant : RestaurantMO!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        // 指南針
        mapView.showsCompass = true
        // 比例尺
        mapView.showsScale = true
        // 交通流量大小
        mapView.showsTraffic = true

        // Do any additional setup after loading the view.
        // 取得位置
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(restaurant.location ?? "", completionHandler: { placemarks, error in
            if let error = error {
                print(error)
                return
            }
            if let placemarks = placemarks {
                print("123456");
                // 取得第一個地點標記
                let placemark = placemarks[0]
                
                // 加上標記
                let annotaion = MKPointAnnotation()
                annotaion.title = self.restaurant.name
                annotaion.subtitle = self.restaurant.type
                
                if let location = placemark.location {
                    // 顯示標記
                    annotaion.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotaion)
                    
                    self.mapView.showAnnotations([annotaion], animated: true)
                    self.mapView.selectAnnotation(annotaion, animated: true)
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyMarker"
        
        if annotation.isKind(of: MKUserLocation.self){
            return nil
        }
        
        var annotationView : MKMarkerAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        // 確認annotationView是否有被使用，若有未使用的mapview，將annotationView變數轉成新的annotationView來使用
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation:annotation,reuseIdentifier:identifier)
        }
        
        annotationView?.glyphText = "😍"
        annotationView?.markerTintColor = UIColor.orange
        
        return annotationView
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
