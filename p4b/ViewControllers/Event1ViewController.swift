//
//  Event1ViewController.swift
//  p4b
//
//  Created by Sagar Ranshur on 13/07/20.
//  Copyright © 2020 Sagar Ranshur. All rights reserved.
//

import UIKit

class Event1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
  

}
