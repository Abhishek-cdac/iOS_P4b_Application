//
//  SelectLangVC.swift
//  p4b
//
//  Created by Sagar Ranshur on 21/07/20.
//  Copyright © 2020 Sagar Ranshur. All rights reserved.
//

import UIKit

class SelectLangVC: UIViewController {

    @IBOutlet weak var uaeRadioImage: UIImageView!
    @IBOutlet weak var ukRadioImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let lang = UserDefaults.standard.value(forKey: Constants.UserDefaults.selectedLanguage) as? String {
            if lang == "Arabic" {
                uaeRadioImage.isHighlighted = true
                ukRadioImage.isHighlighted = false
            }else {
                uaeRadioImage.isHighlighted = false
                ukRadioImage.isHighlighted = true
            }
        }
    }
    
    @IBAction func arabicBtnClicked(_ sender: UITapGestureRecognizer) {
        !uaeRadioImage.isHighlighted ? (uaeRadioImage.isHighlighted = true) : (ukRadioImage.isHighlighted = false)
        ukRadioImage.isHighlighted = false
     }
     
     @IBAction func englishBtnClicked(_ sender: UITapGestureRecognizer) {
        
        !ukRadioImage.isHighlighted ? (ukRadioImage.isHighlighted = true) : (uaeRadioImage.isHighlighted = false)
        uaeRadioImage.isHighlighted = false
     }
    
    
    @IBAction func changeLanguageBtnClicked(_ sender: CustomButton) {
        
        var selectedLangExtnStr = ""
        var selectedLangStr = ""
        if ukRadioImage.isHighlighted  {
            selectedLangExtnStr = "en"
            selectedLangStr = "English"
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }else {
            selectedLangExtnStr = "ar"
            selectedLangStr = "Arabic"
            UIView.appearance().semanticContentAttribute = .forceRightToLeft

        }
        
        self.restartApplication(extStr: selectedLangExtnStr, langStr: selectedLangStr)
        
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
