//
//  Singleton.swift
//  WFMS
//
//  Created by NectarInfotel2 on 27/02/20.
//  Copyright © 2020 NectarInfotel2. All rights reserved.
//

import UIKit

enum ServerType: Int {
    case local
    case uat
    case prod
}


enum UIUserInterfaceIdiom : Int {
    case unspecified

    case phone // iPhone and iPod touch style UI
    case pad   // iPad style UI (also includes macOS Catalyst)
}

class Singleton: NSObject {
    
    
    static let sharedManager = Singleton()
    
    var hostName: String = ""
    var uatHostName: String = ""
    var prodHostName: String = ""

    var authKey: String = ""
    var clientName: String = ""
    var isAdmin = false
    
    var selectedEnviornment = ""
        
    
    let currentDevice = UIDevice.current.userInterfaceIdiom
    
    override init()
    {
        super.init()
        selectedEnviornment = selectServerType(serverType: .uat)
    }
    
    
    func selectServerType(serverType: ServerType) -> String
    {
        switch serverType
        {
            
        case .local:
            hostName = Constants.HostName.localBaseURL
            return hostName
            
        case .uat:
            hostName = Constants.HostName.uatBaseURL
            return hostName
            
        case .prod:
            hostName = Constants.HostName.prodBaseURL
            return hostName
            
        default: return hostName

        }
    }
    
}
