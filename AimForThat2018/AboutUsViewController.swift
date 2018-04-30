//
//  AboutUsViewController.swift
//  AimForThat2018
//
//  Created by Max Alva on 29/04/18.
//  Copyright © 2018 Max Alva. All rights reserved.
//

import UIKit
import WebKit

class AboutUsViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let myURL = URL(string: "https://www.apple.com")
        if let htmlFile = Bundle.main.url(forResource: "AimForThat", withExtension: "html"){
            let myRequest = URLRequest(url: htmlFile)
            webView.load(myRequest)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backPressend() {
        dismiss(animated: true, completion: nil)
    }

}
