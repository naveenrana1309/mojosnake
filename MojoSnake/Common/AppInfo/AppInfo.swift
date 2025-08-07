//
//  AppInfo.swift
//  ReelsSaver
//
//  Created by Naveen Rana on 25/10/22.
//

import Foundation


struct AppInfo {
    static var appname: String {
        guard let dictionary = Bundle.main.infoDictionary else {
            return ""
        }
        if let displayName : String = dictionary["CFBundleDisplayName"] as? String {
            return displayName
        }

        if let name : String = dictionary["CFBundleName"] as? String {
            return name
        }
                
        return ""
    }
    
    static var bundleIdentifier: String {
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            return bundleIdentifier
        }
        return "com.appideas.ReelsSaver"
    }
    
    static var appVersion: String {
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return appVersion
        }
        return "3.0.0"
    }
    
    static let urlScheme = "reelsaver"
    static let platform = "ios"

}
