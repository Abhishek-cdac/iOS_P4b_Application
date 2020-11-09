//
//  ContactUsViewController.swift
//  p4b
//
//  Created by Sagar Ranshur on 10/07/20.
//  Copyright © 2020 Sagar Ranshur. All rights reserved.
//

import UIKit
import CoreLocation

class ContactUsViewController: UIViewController {
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var customNavigationBar: UIView!
    @IBOutlet weak var baseView: UIView!
    
    @IBOutlet weak var nameCustomText: CustomTextField!
    @IBOutlet weak var emailCustomText: CustomTextField!
    @IBOutlet weak var contactNoCustomText: CustomTextField!
    @IBOutlet weak var businessNameCustomText: CustomTextField!
    @IBOutlet weak var cityCustomText: CustomTextField!
    
    @IBOutlet weak var addressCustomTextView: CustomTextView!
    @IBOutlet weak var messageCustomTextView: CustomTextView!
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp () {
        submitBtn.layer.cornerRadius = 20
        customNavigationBar.elevate(elevation: 2.0)
        customNavigationBar.elevate(elevation: 2.0)
        nameCustomText.placeHolder = "Name".localised()
        emailCustomText.placeHolder = "Email".localised()
        contactNoCustomText.placeHolder = "Contact No".localised()
        businessNameCustomText.placeHolder = "Business Name".localised()
        cityCustomText.placeHolder = "City".localised()
        addressCustomTextView.placeHolder = "Address".localised()
        messageCustomTextView.placeHolder = "Message".localised()
        //        baseView.elevate(elevation: 2.0)
        
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitBtnClicked(_ sender: UIButton) {
        
        let locStatus = CLLocationManager.authorizationStatus()
        switch locStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return
        case .denied, .restricted:
            let alert = UIAlertController(title: "Location Services are disabled".localised(), message: "Please enable Location Services in your Settings".localised(), preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK".localised(), style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            return
        case .authorizedAlways, .authorizedWhenInUse:
            
            let alert = UIAlertController.init(title: "Message".localised(), message: "Thanks for contacting us,We'll reach you soon!".localised(), preferredStyle: .alert)
            let action = UIAlertAction.init(title: "OK".localised(), style: .default) { (action) in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(action);
            self.present(alert, animated: true, completion: nil)
            
            break
        @unknown default:
            fatalError()
        }
        
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
