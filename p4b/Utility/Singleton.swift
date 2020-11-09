//
//  Singleton.swift
//  WFMS
//
//  Created by NectarInfotel2 on 27/02/20.
//  Copyright © 2020 NectarInfotel2. All rights reserved.
//

import UIKit

import UIKit

enum ServerType: Int {
    case nDatu
    case Demo
    case MSDL
}


enum UIUserInterfaceIdiom : Int {
    case unspecified

    case phone // iPhone and iPod touch style UI
    case pad   // iPad style UI (also includes macOS Catalyst)
}

class Singleton: NSObject {
    
    
    static let sharedManager = Singleton()
    
    var nDatuHostName: String = ""
    var nDatuDemoHostName: String = ""
    var nDatuMSDLHostName: String = ""

    var authKey: String = ""
    var clientName: String = ""
    var isAdmin = false
    
    var selectedEnviornment = ""
        
    
    let currentDevice = UIDevice.current.userInterfaceIdiom
    
    override init()
    {
        super.init()
//        selectedEnviornment = selectServerType(serverType: .UAT)
    }
    
    
    func selectServerType(serverType: ServerType) -> String
    {
        switch serverType
        {
            
        case .nDatu:
            nDatuHostName = Constants.HostName.strnDatuBaseURL
            return nDatuHostName
            
        case .Demo:
            nDatuHostName = Constants.HostName.strDemoBaseURL
            return nDatuHostName
            
        case .MSDL:
            nDatuMSDLHostName = Constants.HostName.strMSDLBaseURL
            return nDatuMSDLHostName

        }
    }
    
}
