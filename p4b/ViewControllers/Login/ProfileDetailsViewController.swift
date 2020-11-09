//
//  ProfileDetailsViewController.swift
//  p4b
//
//  Created by Sagar Ranshur on 10/08/20.
//  Copyright © 2020 Sagar Ranshur. All rights reserved.
//

import UIKit

class ProfileDetailsViewController: UIViewController {
    
    @IBOutlet weak var universityNameTxtfield: CustomTextField!
    @IBOutlet weak var degreeTxtfield: CustomTextField!
    @IBOutlet weak var gradeTxtfield: CustomTextField!
    
    var isFromDashboard : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func updateProfileAPICall() {
        
        Utility.startIndicator()
            
        let requestparameters = ["student_id"  : 1,
                "name" : "satishS",
                "mobile" : "",
                "email": "",
                "university" : universityNameTxtfield.textField.text!,
                "degree" : degreeTxtfield.textField.text!,
                "grade" : gradeTxtfield.textField.text!,
                                    ] as [String : Any]
            
            WebService.requestServiceWithParametersPostMethod(url: Constants.singleton.hostName, requestType: Constants.RequestType.register, parameters: requestparameters) { (data, error) in
                do {
                    Utility.hideIndicator()
                    
                    if let jsonData = data {
                        let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String : Any]
                        if let loginDetailsObject = SignUpModel.init(JSON: json!)
                        {
                            if loginDetailsObject.success == true {
                                
                                self.handleResponse()
                                
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
                    OperationQueue.main.addOperation {
                        self.showAlert(title: "Message", message: Constants.validationMesages.tryAgainError, vc: self)
                    }
                }
            }
        }
    
    func handleResponse()  {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.Notifications.loginNotification), object: nil, userInfo: nil)
        let userdefaults = UserDefaults.standard
        userdefaults.set(true, forKey: Constants.UserDefaults.isProfileUpdated)
        userdefaults.synchronize()
        self.dismiss(animated: true, completion: nil)
    }
    
    func validateFields() -> Bool {
        
        if universityNameTxtfield.textField.text!.isEmpty {
            universityNameTxtfield.showErrorMessage(errorMessage: Constants.validationMesages.emptyUsername)
            return false
        }else if degreeTxtfield.textField.text!.isEmpty {
            degreeTxtfield.showErrorMessage(errorMessage: Constants.validationMesages.validateEmailid)
            return false
        }else if gradeTxtfield.textField.text!.isEmpty {
            gradeTxtfield.showErrorMessage(errorMessage: Constants.validationMesages.emptyMobile)
            return false
        }
        
        return true
    }
    
    @IBAction func saveBtnClicked(_ sender: CustomButton) {
        if validateFields() {
//            updateProfileAPICall()
            handleResponse()
        }
    }
}
