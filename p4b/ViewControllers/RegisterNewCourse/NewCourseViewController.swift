//
//  NewCourseViewController.swift
//  p4b
//
//  Created by Sagar Ranshur on 16/07/20.
//  Copyright © 2020 Sagar Ranshur. All rights reserved.
//

import UIKit
import CoreLocation

class NewCourseViewController: UIViewController {
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var customNavigationBar: UIView!
    @IBOutlet weak var nameTxtField: CustomTextField!
    @IBOutlet weak var emailTxtField: CustomTextField!
    @IBOutlet weak var contactNoTxt: CustomTextField!
    @IBOutlet weak var universityTxtField: CustomTextField!
    @IBOutlet weak var degreeTxtField: CustomTextField!
    @IBOutlet weak var gradeTxtField: CustomTextField!
    @IBOutlet weak var remarksTxtView: CustomTextView!
    
    @IBOutlet weak var courseTitle: UILabel!
    @IBOutlet weak var courseDurationLable: UILabel!
    @IBOutlet weak var courseStartDateLabel: UILabel!
    @IBOutlet weak var applicantsLabel: UILabel!
    @IBOutlet weak var teacherNameLable: UILabel!
    @IBOutlet weak var courseCostLable: UILabel!
    
    let locationManager = CLLocationManager()
    
    var courseArray = [Constants.Course]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func registerForNewCourseAPI() {
        
        Utility.startIndicator()
        
        let requestparameters = ["name" : nameTxtField.textField.text,
                                 "mobile" : contactNoTxt.textField.text,
                                 "email": emailTxtField.textField.text,
                                 "country_code": "91",
                                 "university" : universityTxtField.textField.text,
                                 "degree" : degreeTxtField.textField.text,
                                 "grade" : gradeTxtField.textField.text,
                                 "address" : "pune",
                                 "password" : "sagar",
                                 "password_confirm" : "sagar"] as [String : Any]
        
        WebService.requestServiceWithParametersPostMethod(url: Constants.singleton.hostName, requestType: Constants.RequestType.register, parameters: requestparameters) { (data, error) in
            do {
                
                Utility.hideIndicator()
                
                if let jsonData = data {
                    let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String : Any]
                    if let loginDetailsObject = LoginModel.init(JSON: json!)
                    {
                        if loginDetailsObject.success == true {
                            
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
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    func setup() {
        nameTxtField.placeHolder = "Name".localised();
        emailTxtField.placeHolder = "Email".localised();
        contactNoTxt.placeHolder = "Contact No".localised();
        universityTxtField.placeHolder = "University".localised()
        degreeTxtField.placeHolder = "Degree".localised()
        gradeTxtField.placeHolder = "Grade".localised()
        remarksTxtView.placeHolder = "Remarks".localised()
        
        baseView.elevate(elevation: 2.0)
        customNavigationBar.elevate(elevation: 2.0)
        contactNoTxt.isMobile = true
        contactNoTxt.extensionStr = "0291 "
        
        courseArray = [
                   Constants.Course.init(title: "Web Design".localised(), duration: "90 days".localised(), startDate: "08/08/2020", teacherName: "Shami Ahmed", applicants: "774"),
                   Constants.Course.init(title: "App Development".localised(), duration: "150 days".localised(), startDate: "02/08/2020", teacherName: "Zamil Sheik", applicants: "316"),
               ];
        
        var username = UserDefaults.standard.value(forKey: Constants.UserDefaults.userDetails) as? [String: String]
        if let userName = username?["name"] {
            nameTxtField.textField.text = userName
        }
        if let email = username?["email"] {
            emailTxtField.textField.text = email
        }
        
        let courseObject = courseArray[0]
        courseTitle.text = courseObject.title
        
        if let lang = UserDefaults.standard.value(forKey: Constants.UserDefaults.selectedLanguage) as? String {
            if lang == "Arabic".localised() {
                courseStartDateLabel.textAlignment = .left
            }else {
                courseStartDateLabel.textAlignment = .right
            }
        }
        
        courseDurationLable.text = "Course Duration".localised() + courseObject.duration
        courseStartDateLabel.text = "Course Start Date".localised() + courseObject.startDate
        teacherNameLable.text = "By ".localised() + courseObject.teacherName
        courseCostLable.text = "Course Cost".localised() + "0.0"
        applicantsLabel.text = courseObject.applicants + " applied".localised()
    }
    
    func validateFields() -> Bool{
        if nameTxtField.textField.text!.isEmpty{
            nameTxtField.showErrorMessage(errorMessage: Constants.validationMesages.emptyUsername)
            return false
        }else if emailTxtField.textField.text!.isEmpty{
            emailTxtField.showErrorMessage(errorMessage: Constants.validationMesages.validateEmailid)
            return false
        }else if !Utility.isValidEmail(testStr: emailTxtField.textField.text!) {
            emailTxtField.showErrorMessage(errorMessage: Constants.validationMesages.validateEmailid)
            return false
        }else if contactNoTxt.textField.text!.isEmpty {
            contactNoTxt.showErrorMessage(errorMessage: Constants.validationMesages.emptyMobile)
            return false
        }
        return true
    }
    
    @IBAction func enrollNowBtnClicked(_ sender: CustomButton) {
        if validateFields() {
            
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
                
                let alert = UIAlertController.init(title: "Message".localised(), message: "Thanks for registration with us".localised(), preferredStyle: .alert)
                let action = UIAlertAction.init(title: "OK".localised(), style: .default) { (action) in
                    self.navigationController?.popViewController(animated: true)
                }
                alert.addAction(action);
                self.present(alert, animated: true, completion: nil)
                
                break
            @unknown default:
                fatalError()
            }
        }
    }
}
