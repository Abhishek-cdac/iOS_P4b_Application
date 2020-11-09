//
//  RegisterForCourseVC.swift
//  p4b
//
//  Created by Sagar Ranshur on 10/07/20.
//  Copyright © 2020 Sagar Ranshur. All rights reserved.
//

import UIKit

class RegisterForCourseVC: UIViewController {

    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var emailIdTxt: UITextField!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var mobileNumberTxt: UITextField!
    @IBOutlet weak var universityTxt: UITextField!
    @IBOutlet weak var courseStatus: UITextField!
    @IBOutlet weak var remarksTxt: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        submitBtn.layer.cornerRadius = 22.5
        
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func submitBtnClicked(_ sender: UIButton) {
//        if emailIdTxt.text!.isEmpty {
//            showAlert(message: "Please enter emailID")
//            return
//        }else if !isValidEmail(emailIdTxt.text!) {
//            showAlert(message: "Please enter valid email Id")
//            return
//        }else if nameTxt.text!.isEmpty {
//            showAlert(message: "Please enter name")
//            return
//        }else if universityTxt.text!.isEmpty {
//            showAlert(message: "Please enter University")
//            return
//        }else if remarksTxt.text!.isEmpty {
//            showAlert(message: "Please enter remarks")
//            return
//        }else if courseStatus.text!.isEmpty {
//            showAlert(message: "Please enter course status")
//            return
//        }
        
        let alert = UIAlertController.init(title: "Message".localised(), message: "Registration Successfull".localised(), preferredStyle: .alert)
        let action = UIAlertAction.init(title: "OK".localised(), style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action);
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func showAlert(message: String) {
        
        let alert = UIAlertController.init(title: "Message".localised(), message: message, preferredStyle: .alert)
        let cancel = UIAlertAction.init(title: "OK".localised(), style: .default, handler: nil)
        alert.addAction(cancel);
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
