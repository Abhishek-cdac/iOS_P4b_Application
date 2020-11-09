//
//  LoginInfoViewController.swift
//  p4b
//
//  Created by Sagar Ranshur on 10/08/20.
//  Copyright © 2020 Sagar Ranshur. All rights reserved.
//

import UIKit

class LoginInfoViewController: UIViewController {

    var isFromDashboard = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginBtnClicked(_ sender: CustomButton) {
        
        let loginVC : LoginViewController
        
        if #available(iOS 13.0, *) {
            loginVC = Constants.Storyboards.main.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        } else {
            // Fallback on earlier versions
            loginVC = Constants.Storyboards.main.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        }
        loginVC.isFromDashboard = true
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @IBAction func registerBtnClicked(_ sender: UIButton) {
        
        let loginVC : SignUpViewController
        
        if #available(iOS 13.0, *) {
            loginVC = Constants.Storyboards.main.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        } else {
            // Fallback on earlier versions
            loginVC = Constants.Storyboards.main.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        }
        
        loginVC.isFromDashboard = true
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    @IBAction func facebookBtnClicked(_ sender: UITapGestureRecognizer) {
    }
    
    @IBAction func googleBtnClicked(_ sender: UITapGestureRecognizer) {
    }
    
}
