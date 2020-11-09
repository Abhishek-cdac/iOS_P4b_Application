//
//  Utility.swift
//  WFMS
//
//  Created by NectarInfotel2 on 27/02/20.
//  Copyright © 2020 NectarInfotel2. All rights reserved.
//

import UIKit
import Alamofire
import KRProgressHUD


class Utility: NSObject {
    
    static let customAlertView = CustomAlertView()
    
    static func setUpAlert(isSingle: Bool, isSuccessAlert: Bool, title: String, message: String,image: String) {
        
        customAlertView.setupAlertWith(isSingle: isSingle, isSuccess: isSuccessAlert, title: title, message: message, image: image)
    }
    
    static func showCustomAlert() {
        customAlertView.showAlert(view: customAlertView.contentView!)
    }
    
    static func removeAlert() {
        customAlertView.removeAlert(view: customAlertView.contentView!)
    }
    
    //Return app version. e.g 1.0
    static func getAppVersion() -> String
    {
        
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        {
            return "I-\(version)"
        }
        else
        {
            return ""
        }
    }
    
    static func getCurrentDateTime() -> String
    {
        let currentDate = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "en")
        
        dateFormatter.dateFormat = "yyyy"
        let year: String = dateFormatter.string(from: currentDate)

        dateFormatter.dateFormat = "MMMM"
        let month: String = dateFormatter.string(from: currentDate)
        
        dateFormatter.dateFormat = "dd"
        let day: String = dateFormatter.string(from: currentDate)

        dateFormatter.dateFormat = "HH"
        let hours: String = dateFormatter.string(from: currentDate)

        dateFormatter.dateFormat = "mm"
        let minutes: String = dateFormatter.string(from: currentDate)

        return "\(day) \(month) \(year) | \(hours):\(minutes)"
    }
    
    // Email ID Validation
    static func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "^[a-zA-Z]([-.0-9\\w]*[a-zA-Z0-9])*@([a-zA-Z][-\\w]*\\.)+[a-zA-Z]{2,9}$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
     static func checkInternetConnection() -> Bool{
          return (NetworkReachabilityManager()?.isReachable)!
      }
    
      static var deviceID : String {
          return  UIDevice.current.identifierForVendor!.uuidString
      }
      
      //PEN Testing
      static func isDeviceJailBroken() -> Bool {
          if TARGET_IPHONE_SIMULATOR != 1
          {
              
              // Check 1 : existence of files that are common for jailbroken devices
              if FileManager.default.fileExists(atPath: "/Applications/Cydia.app")
                  || FileManager.default.fileExists(atPath: "/bin/sh")
                  || FileManager.default.fileExists(atPath: "/usr/libexec/ssh-keysign")
                  || FileManager.default.fileExists(atPath: "/usr/bin/sshd")
                  || FileManager.default.fileExists(atPath: "/usr/libexec/sftp-server")
                  || FileManager.default.fileExists(atPath: "/etc/ssh/sshd_config")
                  || FileManager.default.fileExists(atPath: "/etc/apt")
                  || FileManager.default.fileExists(atPath: "/Applications/RockApp.app")
                  || FileManager.default.fileExists(atPath: "/Applications/Icy.app")
                  || FileManager.default.fileExists(atPath: "/Applications/WinterBoard.app")
                  || FileManager.default.fileExists(atPath: "/Applications/SBSettings.app")
                  || FileManager.default.fileExists(atPath: "/Applications/MxTube.app")
                  || FileManager.default.fileExists(atPath: "/Applications/IntelliScreen.app")
                  || FileManager.default.fileExists(atPath: "/Applications/FakeCarrier.app")
                  || FileManager.default.fileExists(atPath: "/Applications/blackra1n.app")
                  || FileManager.default.fileExists(atPath: "/usr/sbin/sshd")
                  || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib")
                  || FileManager.default.fileExists(atPath: "/bin/bash")
                  || FileManager.default.fileExists(atPath: "/private/var/stash")
                  || FileManager.default.fileExists(atPath: "/bin/bash")
                  || FileManager.default.fileExists(atPath: "/etc/apt")
                  || FileManager.default.fileExists(atPath: "/private/var/lib/apt/")
                  || FileManager.default.fileExists(atPath: "/private/var/lib/cydia")
                  || FileManager.default.fileExists(atPath: "/private/var/mobile/Library/SBSettings/Themes")
                  || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib")
                  || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/DynamicLibraries/Veency.plist")
                  || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist")
                  || FileManager.default.fileExists(atPath: "/System/Library/LaunchDaemons/com.ikey.bbot.plist")
                  || FileManager.default.fileExists(atPath: "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist")
                  || FileManager.default.fileExists(atPath: "/var/cache/apt")
                  || FileManager.default.fileExists(atPath: "/var/lib/apt")
                  || FileManager.default.fileExists(atPath: "/var/lib/cydia")
                  || FileManager.default.fileExists(atPath: "/var/log/syslog")
                  || FileManager.default.fileExists(atPath: "/var/tmp/cydia.log")
                  || FileManager.default.fileExists(atPath: "/private/var/tmp/cydia.log")
                  || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/DynamicLibraries/Liberty.dylib")
                  || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/DynamicLibraries/zLiberty.dylib")
                  || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/DynamicLibraries/zzLiberty.dylib")
                  || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/DynamicLibraries/zzzLiberty.dylib")
                  || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/DynamicLibraries/zzzzLiberty.dylib")
                  || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/DynamicLibraries/zzzzzLiberty.dylib")
                  || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/DynamicLibraries/xCon.dylib")
                  || UIApplication.shared.canOpenURL(URL(string:"cydia://package/com.ryleyangus.libertylite")!)
                  || UIApplication.shared.canOpenURL(URL(string:"cydia://package/com.")!)
                  
              {
                  return true
              }
              
              
              // Check 2 : Reading and writing in system directories (sandbox violation)
              let stringToWrite = "Jailbreak Test"
              do
              {
                  try stringToWrite.write(toFile:"/private/JailbreakTest.txt", atomically:true, encoding:String.Encoding.utf8)
                  //Device is jailbroken
                  return true
              }catch
              {
                  return false
              }
          }else
          {
              return false
          }
      }
    
    static func printLog(key: String, value: Any)
    {
        #if DEBUG
            print("\(key) = ")
            print("\(value)\n\n\n")
        #endif
    }
    
    static func startIndicator() {
        KRProgressHUD.show()
    }
    
    static func hideIndicator() {
        KRProgressHUD.dismiss()
    }
    
    static func showAlert(message: String) {
        
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)

        var rootViewController = UIApplication.shared.keyWindow?.rootViewController
        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.viewControllers.last
        }
        let action = UIAlertAction.init(title: "OK", style: .cancel) { (UIAlertAction) in
            rootViewController?.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    
    
}
