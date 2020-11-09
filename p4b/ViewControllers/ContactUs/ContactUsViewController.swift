//
//  ContactUsViewController.swift
//  p4b
//
//  Created by Sagar Ranshur on 10/07/20.
//  Copyright © 2020 Sagar Ranshur. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {

    @IBOutlet weak var emailIdBaseView: UIView!
    @IBOutlet weak var businessBaseView: UIView!
    @IBOutlet weak var ceoNameBaseView: UIView!
    @IBOutlet weak var mobileNumberBaseView: UIView!
    @IBOutlet weak var addrsBaseView: UIView!
    @IBOutlet weak var cityBaseView: UIView!
    @IBOutlet weak var commentsBaseView: UIView!
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var emailIdAddrs: UITextField!
    @IBOutlet weak var bussnessNameTxt: UITextField!
    @IBOutlet weak var ceoNameTxt: UITextField!
    @IBOutlet weak var mobileNoTxt: UITextField!
    @IBOutlet weak var addrsTxt: UITextView!
    @IBOutlet weak var cityTxt: UITextField!
    @IBOutlet weak var commentsTxt: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp () {
        submitBtn.layer.cornerRadius = 20
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitBtnClicked(_ sender: UIButton) {
        
//        if emailIdAddrs.text!.isEmpty {
//            showAlert(message: "Please enter emailID")
//            return
//        }else if !isValidEmail(emailIdAddrs.text!) {
//            showAlert(message: "Please enter valid email Id")
//            return
//        }else if bussnessNameTxt.text!.isEmpty {
//            showAlert(message: "Please enter business name")
//            return
//        }else if ceoNameTxt.text!.isEmpty {
//            showAlert(message: "Please enter CEO Name")
//            return
//        }else if mobileNoTxt.text!.isEmpty {
//            showAlert(message: "Please enter Mobile Number")
//            return
//        }else if addrsTxt.text.isEmpty {
//            showAlert(message: "Please enter address")
//            return
//        }else if cityTxt.text!.isEmpty {
//            showAlert(message: "Please enter City Name")
//            return
//        }else if commentsTxt.text.isEmpty {
//            showAlert(message: "Please enter comments")
//            return
//        }
        
        let alert = UIAlertController.init(title: "Message".localised(), message: "Thanks for contacting us,We'll reach you soon!".localised(), preferredStyle: .alert)
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
