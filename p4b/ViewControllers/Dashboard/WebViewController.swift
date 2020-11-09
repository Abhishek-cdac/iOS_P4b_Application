//
//  WebViewController.swift
//  p4b
//
//  Created by Sagar Ranshur on 27/07/20.
//  Copyright © 2020 Sagar Ranshur. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var customNavigationBar: UIView!
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        activityIndicator.hidesWhenStopped = true
        setUpView(url: url as NSString)
    }
    
    func setUpView(url: NSString)  {
        
        customNavigationBar.elevate(elevation: 2.0)
        activityIndicator.startAnimating();
        let link = URL(string: url as String)!
        let request = URLRequest(url: link)
        webView.load(request)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating();
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
