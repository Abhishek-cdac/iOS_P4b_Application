//
//  LoginViewController.swift
//  p4b
//
//  Created by Sagar Ranshur on 10/07/20.
//  Copyright © 2020 Sagar Ranshur. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailIdTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setUp() {
        emailIdTxt.layer.cornerRadius = 20;
        passwordTxt.layer.cornerRadius = 20;
        loginBtn.layer.cornerRadius = 20;
    }
    
    @IBAction func loginBtnClicked(_ sender: UIButton) {
        
//        if emailIdTxt.text!.isEmpty {
//            showAlert(message: "Please enter email Address");
//            return
//        }else if !isValidEmail(emailIdTxt.text!) {
//            showAlert(message: "Please enter valid email address")
//            return
//        }
//        else if passwordTxt.text!.isEmpty {
//            showAlert(message: "Please enter password");
//            return
//        }
        
        let dashboardVC = Constants.Storyboards.main.instantiateViewController(identifier: "DashboardVC") as! DashboardVC
        navigationController?.pushViewController(dashboardVC, animated: true)
    }
    
    func showAlert(message: String) {
        
        let alert = UIAlertController.init(title: "Message".localised(), message: message, preferredStyle: .alert)
        let cancel = UIAlertAction.init(title: "OK".localised(), style: .default, handler: nil)

//        alert.addAction(action);
        alert.addAction(cancel);
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

