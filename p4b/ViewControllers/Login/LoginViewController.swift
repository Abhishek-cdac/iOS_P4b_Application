//
//  LoginViewController.swift
//  p4b
//
//  Created by Sagar Ranshur on 10/07/20.
//  Copyright © 2020 Sagar Ranshur. All rights reserved.
//

import UIKit
import ObjectMapper

class LoginViewController: UIViewController {
    
    @IBOutlet weak var passwordTxt: CustomTextField!
    @IBOutlet weak var emailIdTxt: CustomTextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var imgRememberMe: UIImageView!
    @IBOutlet weak var lblRememberMe: UILabel!
    
    var isFromDashboard = false
    var isChecked = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setUp() {
        handleGestureForRememberMe()
        emailIdTxt.layer.cornerRadius = 20;
        passwordTxt.layer.cornerRadius = 20;
        loginBtn.layer.cornerRadius = 20;
//        emailIdTxt.textField.text = "admin@gmail.com";
//        passwordTxt.textField.text = "admin@demo";
        passwordTxt.textField.isSecureTextEntry = true
    }
    
    func handleGestureForRememberMe(){
        let tapMenu = UITapGestureRecognizer(target: self, action: #selector(addGetsureForImage))
        let tapMenu2 = UITapGestureRecognizer(target: self, action: #selector(addGetsureForImage))
        
        self.imgRememberMe.isUserInteractionEnabled = true
        self.lblRememberMe.isUserInteractionEnabled = true
        self.imgRememberMe.addGestureRecognizer(tapMenu)
        self.lblRememberMe.addGestureRecognizer(tapMenu2)
    }
    
    @objc func addGetsureForImage(){
        if isChecked{
            self.imgRememberMe.image = UIImage(named: "unselected_checkbox")
            isChecked = false
        }else{
            self.imgRememberMe.image = UIImage(named: "checkbox_selected")
            isChecked = true
        }
    }
    
    func loginAPICall() {
        
        Utility.startIndicator()
        
        let url = "email=\(emailIdTxt.textField.text!)&password=\(passwordTxt.textField.text!)";
        
        WebService.requestServiceWithGetMethod(url: url, requestType: Constants.RequestType.login) { (data, error) in
            do {
                
                Utility.hideIndicator()
                
                if let jsonData = data {
                    let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String : Any]
                    if let loginDetailsObject = LoginModel.init(JSON: json!)
                    {
                        if loginDetailsObject.success == true {
                            self.handleLoginResponse(resObject: loginDetailsObject)
                        }else {
                            Utility.showAlert(message: loginDetailsObject.message)
                        }
                    }
                }else {
                    Utility.showAlert(message: Constants.validationMesages.tryAgainError)
                }
                
            }catch {
                Utility.showAlert(message: Constants.validationMesages.tryAgainError)
            }
        }
    }
    
    func handleLoginResponse(resObject: LoginModel) {
        
        saveUserDetails(user: resObject.data[0])
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: Constants.Notifications.loginNotification), object: nil, userInfo: nil)
        
        
        if !isFromDashboard {
            self.dismiss(animated: true, completion: nil)
        }else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func loginBtnClicked(_ sender: UIButton) {
        
        if emailIdTxt.textField.text!.isEmpty {
            showAlert(message: "Please enter email Address");
            return
        }else if !isValidEmail(emailIdTxt.textField.text!) {
            showAlert(message: "Please enter valid email address")
            return
        }
        else if passwordTxt.textField.text!.isEmpty {
            showAlert(message: "Please enter password");
            return
        }
        
        loginAPICall()
    }
    
    func setRootVC() {
        
        let viewController : DashboardVC
        
        if #available(iOS 13.0, *) {
            viewController = Constants.Storyboards.main.instantiateViewController(identifier: "DashboardVC") as! DashboardVC
        } else {
            // Fallback on earlier versions
            viewController = Constants.Storyboards.main.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
        }
        
        
        let navigationController = UINavigationController.init(rootViewController: viewController)
        navigationController.isNavigationBarHidden = true
        
    }
    
    
    func saveUserDetails(user: UserObject) {
        
        let userDetails: [String: String] = [ "name": user.first_name, "email": user.email]
        
        let userdefaults = UserDefaults.standard
        userdefaults.set(true, forKey: Constants.UserDefaults.isUserLogin)
        userdefaults.set(userDetails, forKey: Constants.UserDefaults.userDetails)
        userdefaults.synchronize()
    }
    
    func showAlert(message: String) {
        
        let alert = UIAlertController.init(title: "Message".localised(), message: message, preferredStyle: .alert)
        let cancel = UIAlertAction.init(title: "OK".localised(), style: .default, handler: nil)
        
        //        alert.addAction(action);
        alert.addAction(cancel);
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func closeBtnClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerBtnClicked(_ sender: UITapGestureRecognizer) {
        var registerVC : SignUpViewController
        if #available(iOS 13.0, *) {
            registerVC = Constants.Storyboards.main.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        } else {
            // Fallback on earlier versions
            registerVC = Constants.Storyboards.main.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        }
        navigationController?.pushViewController(registerVC, animated: true)
    }
    
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

class LoginModel : Mappable {
    var success: Bool = false
    var message: String = ""
    var token: String = ""
    var data = [UserObject]()
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        token <- map["token"]
        data <- map["data"]
    }
}

class UserObject : Mappable {
    var id: Int = 0
    var name: String = ""
    var first_name: String = ""
    var last_name: String = ""
    var country_code: String = ""
    var mobile: String = ""
    var is_active: Int = 0
    var is_deleted: Int = 0
    var created_by: Int = 0
    var updated_by: Int = 0
    var created_at: String = ""
    var updated_at: String = ""
    var email: String = ""
    var email_verified_at: String = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        first_name <- map["first_name"]
        last_name <- map["last_name"]
        country_code <- map["country_code"]
        mobile <- map["mobile"]
        is_active <- map["is_active"]
        is_deleted <- map["is_deleted"]
        created_by <- map["created_by"]
        updated_by <- map["updated_by"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        email <- map["email"]
        email_verified_at <- map["email_verified_at"]
    }
}

