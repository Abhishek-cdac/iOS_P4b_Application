//
//  ViewController.swift
//  p4b
//
//  Created by Sagar Ranshur on 10/07/20.
//  Copyright © 2020 Sagar Ranshur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var customNavigationBar: UIView!
    
    @IBOutlet weak var nameTxtField: CustomTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.elevate(elevation: 2.0)
        customNavigationBar.elevate(elevation: 2.0)
    }
}

