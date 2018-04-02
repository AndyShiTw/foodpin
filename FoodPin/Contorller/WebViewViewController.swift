//
//  WebViewViewController.swift
//  FoodPin
//
//  Created by HSU JUI-FU on 2018/4/2.
//  Copyright © 2018年 AndyShi. All rights reserved.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {
    @IBOutlet var webView : WKWebView!
    
    var targetURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.largeTitleDisplayMode = .never
        
        if let url = URL(string: targetURL){
            let request = URLRequest(url:url)
            webView.load(request)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
