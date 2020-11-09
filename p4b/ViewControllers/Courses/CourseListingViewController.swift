//
//  CourseListingViewController.swift
//  p4b
//
//  Created by Sagar Ranshur on 15/07/20.
//  Copyright © 2020 Sagar Ranshur. All rights reserved.
//

import UIKit
import ObjectMapper

class CourseListingViewController: UIViewController {

    @IBOutlet weak var courseListTableView: UITableView!
    @IBOutlet weak var customNavigationView: UIView!
    
    var coursesArray = [CourseModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customNavigationView.elevate(elevation: 2.0)
        getEventListing()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.loginNotification(_:)), name: NSNotification.Name(rawValue: Constants.Notifications.loginNotification), object: nil)

    }
    
    @objc func loginNotification(_ notification: NSNotification) {
        checkLoginAndProfileUpdate()
    }
    
    func checkLoginAndProfileUpdate() {
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: Constants.UserDefaults.isUserLogin)
        let isProfileUpdated = UserDefaults.standard.bool(forKey: Constants.UserDefaults.isProfileUpdated)
        var username = UserDefaults.standard.value(forKey: Constants.UserDefaults.userDetails) as? String
        
        
        
        if !isLoggedIn {
                    
                   let loginVC : LoginInfoViewController
                    if #available(iOS 13.0, *) {
                        loginVC = Constants.Storyboards.main.instantiateViewController(identifier: "LoginInfoViewController") as! LoginInfoViewController
                    } else {
                        // Fallback on earlier versions
                        loginVC = Constants.Storyboards.main.instantiateViewController(withIdentifier: "LoginInfoViewController") as! LoginInfoViewController
                    }
                    
                    let navController = UINavigationController.init(rootViewController: loginVC)
                    self.present(navController, animated: true, completion: nil)
                    
                }else {
                    
                    let register : NewCourseViewController

                    if #available(iOS 13.0, *) {
                         register = Constants.Storyboards.main.instantiateViewController(identifier: "NewCourseViewController") as! NewCourseViewController
                    } else {
                        // Fallback on earlier versions
                        register = Constants.Storyboards.main.instantiateViewController(withIdentifier: "NewCourseViewController") as! NewCourseViewController
                    }
                    
        //            register.courseArray = coursesArray
                    navigationController?.pushViewController(register, animated: true)
                }
    }

    
    //MARK: - API CALL Method
    //MARK: -
    
    func getEventListing()  {
        
        Utility.startIndicator()
    
        WebService.requestServiceWithPostMethod(url: Constants.singleton.hostName, requestType: Constants.RequestType.course) { (data, error) in
            
            do {
                Utility.hideIndicator()
                
                if let jsonData = data {
                    let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String : Any]
                    
                    if let objectModel = CourseObject.init(JSON: json!) {
                        if objectModel.success == true {
                            self.getData(objectModel: objectModel)
                        }
                    }
                }else {
                    print("receive nil data")
                }
                
            }catch {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - API Processing Methods
    //MARK: -
    
    func getData(objectModel: CourseObject) {
        self.coursesArray = objectModel.data as! [CourseModel]
        self.courseListTableView.reloadData()
    }

    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension CourseListingViewController: UITableViewDelegate,UITableViewDataSource, CourseProtocol {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coursesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = courseListTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CourseListTableViewCell
        
        cell.delegate = self
        
        if let lang = UserDefaults.standard.value(forKey: Constants.UserDefaults.selectedLanguage) as? String {
            if lang == "Arabic".localised() {
                cell.courseStartDateLabel.textAlignment = .left
            }
        }

        
        let coursesObj = coursesArray[indexPath.row]
//        cell.courseNameLabel.text = coursesObj.title + " | "
//        cell.courseDurationLabel.text = "Course Duration".localised() + " : " + coursesObj.duration
//        cell.courseStartDateLabel.text = "Course Start Date".localised() + " : " + coursesObj.startDate
//        cell.teacherName.text = "By " + coursesObj.teacherName
//        cell.applicantsLable.text = coursesObj.applicants + " applied".localised()
        cell.baseView.elevate(elevation: 2.0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    //course protocol delegate method
    func enrollNowBtnClicked() {
        let isLoggedIn = UserDefaults.standard.bool(forKey: Constants.UserDefaults.isUserLogin)
        var username = UserDefaults.standard.value(forKey: Constants.UserDefaults.userDetails) as? String

        if !isLoggedIn {
            
           let loginVC : LoginInfoViewController
            if #available(iOS 13.0, *) {
                loginVC = Constants.Storyboards.main.instantiateViewController(identifier: "LoginInfoViewController") as! LoginInfoViewController
            } else {
                // Fallback on earlier versions
                loginVC = Constants.Storyboards.main.instantiateViewController(withIdentifier: "LoginInfoViewController") as! LoginInfoViewController
            }
            
            let navController = UINavigationController.init(rootViewController: loginVC)
            loginVC.isFromDashboard = true
            self.present(navController, animated: true, completion: nil)
            
        }else {
            
            let register : NewCourseViewController

            if #available(iOS 13.0, *) {
                 register = Constants.Storyboards.main.instantiateViewController(identifier: "NewCourseViewController") as! NewCourseViewController
            } else {
                // Fallback on earlier versions
                register = Constants.Storyboards.main.instantiateViewController(withIdentifier: "NewCourseViewController") as! NewCourseViewController
            }
            
//            register.courseArray = coursesArray
            navigationController?.pushViewController(register, animated: true)
        }
    }
    
    //login delegate methods
    func loginBtnClicked() {
        
        let register : NewCourseViewController

        if #available(iOS 13.0, *) {
             register = Constants.Storyboards.main.instantiateViewController(identifier: "NewCourseViewController") as! NewCourseViewController
        } else {
            // Fallback on earlier versions
            register = Constants.Storyboards.main.instantiateViewController(withIdentifier: "NewCourseViewController") as! NewCourseViewController
        }
        
//        register.courseArray = coursesArray
        navigationController?.pushViewController(register, animated: true)
    }
}


class CourseObject: Mappable {
    var success: Bool = false
    var message: String = ""
    var data = [CourseModel]()
   
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        data <- map["data"]
    }
}
