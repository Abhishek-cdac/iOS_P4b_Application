//
//  SettingsViewController.swift
//  SelfCare
//
//  Created by Sagar Ranshur on 21/05/20.
//  Copyright © 2020 Sagar Ranshur. All rights reserved.
//

import UIKit
import DropDown

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var selectedBtn: UIButton!
    var selectedLanguage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//    @IBAction func backBtnClicked(_ sender: UIButton) {
//        navigationController?.popViewController(animated: true)
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let lang: String = UserDefaults.standard.value(forKey: Constants.UserDefaults.selectedLanguage) as? String {
            
            selectedBtn.setTitle(lang.localised(), for: .normal)
        }
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectLanguageClicked(_ sender: UIButton) {
        
        let selectLang : SelectLangVC
        if #available(iOS 13.0, *) {
              selectLang = Constants.Storyboards.main.instantiateViewController(identifier: "SelectLangVC") as! SelectLangVC
        } else {
            // Fallback on earlier versions
            selectLang = Constants.Storyboards.main.instantiateViewController(withIdentifier: "SelectLangVC") as! SelectLangVC
        }

        navigationController?.pushViewController(selectLang, animated: true)
        
//        let data = ["English", "Arabic"]
//        let dropDown = DropDown()
//        dropDown.anchorView = self.selectedBtn // UIView or UIBarButtonItem
//        dropDown.width = self.selectedBtn.frame.size.width
//        dropDown.direction = .top
//        dropDown.bottomOffset = CGPoint.init(x: self.selectedBtn.frame.origin.x, y: self.selectedBtn.frame.origin.y)
//
//        // The list of items to display. Can be changed dynamically
//        dropDown.dataSource = data
//        dropDown.selectionAction = { (index: Int, item: String) in
//
//            var selectedLangExtnStr = ""
//            var selectedLangStr = ""
//            if index == 0 {
//                selectedLangExtnStr = "en"
//                selectedLangStr = "English"
//            }else {
//                selectedLangExtnStr = "ar"
//                selectedLangStr = "Arabic"
//            }
//
//            self.restartApplication(extStr: selectedLangExtnStr, langStr: selectedLangStr)
//        }
//        dropDown.show()
    }
    
    func restartApplication (extStr: String, langStr: String) {
        
        UserDefaults.standard.set([extStr], forKey: Constants.UserDefaults.applanguages)
        UserDefaults.standard.synchronize()
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(langStr, forKey: Constants.UserDefaults.selectedLanguage)
        userDefaults.synchronize()
        
        Bundle.setLanguage(extStr)
        
        showAlert(message: "Your app language changed successfully!".localised());
        
    }
    
    func showAlert(message: String) {
            
            let alert = UIAlertController.init(title: "Message".localised(), message: message, preferredStyle: .alert)
        let action = UIAlertAction.init(title: "OK".localised(), style: .cancel) { (action) in
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            UIApplication.shared.keyWindow?.rootViewController = storyboard.instantiateInitialViewController()

        }
            alert.addAction(action);
            self.present(alert, animated: true, completion: nil)
        }
}
