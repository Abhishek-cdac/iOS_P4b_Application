//
//  SignUpViewController.swift
//  p4b
//
//  Created by Sagar Ranshur on 10/08/20.
//  Copyright © 2020 Sagar Ranshur. All rights reserved.
//

import UIKit
import ObjectMapper

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTxtfield: CustomTextField!
    @IBOutlet weak var emailTxtfield: CustomTextField!
    @IBOutlet weak var contactNoTxtfield: CustomTextField!
    @IBOutlet weak var passwordTxtfield: CustomTextField!
    @IBOutlet weak var confPasswordTxtfield: CustomTextField!
    @IBOutlet weak var checkBoxImage: UIImageView!
    
    
    var isFromDashboard : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp() {
        contactNoTxtfield.isMobile = true
        contactNoTxtfield.extensionStr = "+291 "
    }
    
    @IBAction func checkboaxBtnClicked(_ sender: UIButton) {
        checkBoxImage.isHighlighted = !checkBoxImage.isHighlighted
    }
    
    func validateFields() -> Bool {
        if nameTxtfield.textField.text!.isEmpty {
            nameTxtfield.showErrorMessage(errorMessage: Constants.validationMesages.emptyUsername)
            return false
        }else if emailTxtfield.textField.text!.isEmpty {
            emailTxtfield.showErrorMessage(errorMessage: Constants.validationMesages.validateEmailid)
            return false
        }else if !Utility.isValidateEmail(emailTxtfield.textField.text!) {
            emailTxtfield.showErrorMessage(errorMessage: Constants.validationMesages.validateEmailid)
            return false
        }else if contactNoTxtfield.textField.text!.isEmpty {
            contactNoTxtfield.showErrorMessage(errorMessage: Constants.validationMesages.emptyMobile)
            return false
        }else if passwordTxtfield.textField.text!.isEmpty {
            passwordTxtfield.showErrorMessage(errorMessage: Constants.validationMesages.emptypassword)
            return false
        }else if confPasswordTxtfield.textField.text!.isEmpty {
            confPasswordTxtfield.showErrorMessage(errorMessage: Constants.validationMesages.emptyConfirmPassword)
            return false
        }else if passwordTxtfield.textField.text != confPasswordTxtfield.textField.text {
            confPasswordTxtfield.showErrorMessage(errorMessage: Constants.validationMesages.passwordMismatch)
            return false
        }
        return true
    }
    
    func registerStudentAPICall() {
        
        Utility.startIndicator()
        
        let requestparameters = ["name" : nameTxtfield.textField.text!,
                                 "mobile" : contactNoTxtfield.textField.text!,
                                 "email": emailTxtfield.textField.text!,
                                 "country_code": "291",
                                 "password" : passwordTxtfield.textField.text!,
                                 "password_confirm" : confPasswordTxtfield.textField.text!] as [String : String]
        
        WebService.requestServiceWithParametersPostMethod(url: Constants.singleton.hostName, requestType: Constants.RequestType.register, parameters: requestparameters) { (data, error) in
            do {
                Utility.hideIndicator()
                
                if let jsonData = data {
                    let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String : Any]
                    if let loginDetailsObject = SignUpModel.init(JSON: json!)
                    {
                        if loginDetailsObject.success == true {
                            
                            self.handleRegisterResponse()
                            
                        }else {
                            OperationQueue.main.addOperation {
                                self.showAlert(title: "Message", message: Constants.validationMesages.tryAgainError, vc: self)
                            }
                        }
                    }
                }else {
                    OperationQueue.main.addOperation {
                        self.showAlert(title: "Message", message: Constants.validationMesages.tryAgainError, vc: self)
                    }
                }
                
            }catch {
//                OperationQueue.main.addOperation {
//                    self.showAlert(title: "Message", message: Constants.validationMesages.tryAgainError, vc: self)
//                }
                
                self.handleRegisterResponse()

            }
        }
    }
    
    func handleRegisterResponse() {
        
        let isProfileUpdated = UserDefaults.standard.bool(forKey: Constants.UserDefaults.isProfileUpdated)
        saveUserDetails(name: nameTxtfield.textField.text!, email: emailTxtfield.textField.text!)
        
        if isProfileUpdated {
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.Notifications.loginNotification), object: nil, userInfo: nil)
            self.dismiss(animated: true, completion: nil)
            
        } else {
            
            let profileVC : ProfileDetailsViewController
            
            if #available(iOS 13.0, *) {
                profileVC = Constants.Storyboards.main.instantiateViewController(identifier: "ProfileDetailsViewController") as! ProfileDetailsViewController
            } else {
                // Fallback on earlier versions
                profileVC = Constants.Storyboards.main.instantiateViewController(withIdentifier: "ProfileDetailsViewController") as! ProfileDetailsViewController
            }
            profileVC.isFromDashboard = true
            self.navigationController?.pushViewController(profileVC, animated: true)
        }
    }
    
    func saveUserDetails(name: String, email: String) {
        
        let userDetails: [String: String] = [ "name": name, "email": email]
        
        let userdefaults = UserDefaults.standard
        userdefaults.set(true, forKey: Constants.UserDefaults.isUserLogin)
        userdefaults.set(userDetails, forKey: Constants.UserDefaults.userDetails)
        userdefaults.synchronize()
    }

    
    @IBAction func registerBtnClicked(_ sender: CustomButton) {
        
        if validateFields() {
            registerStudentAPICall()
        }
    }
    
}

class SignUpModel : Mappable {
    var success: Bool = false
    var message: String = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
    }
}

