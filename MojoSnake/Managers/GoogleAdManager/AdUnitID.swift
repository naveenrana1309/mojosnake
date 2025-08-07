//
//  AdUnitID.swift
//  ReelsSaver
//
//  Created by Naveen Rana on 27/10/22.
//

import Foundation


enum AdUnitID {
    case interstitialAd
    case banner
    case homeBanner
    case appopen
    
    var unitID: String {
        switch self {
        case .interstitialAd:
            if Configuration.isDebug {
                return "ca-app-pub-3940256099942544/4411468910" //Test Unit
            }
                return "ca-app-pub-6202941020778268/2568105313" // Production ad unit
            
        case .homeBanner:
            if Configuration.isDebug {
                return "ca-app-pub-3940256099942544/2934735716" // Test Unit
            }
              
            return "ca-app-pub-6202941020778268/6730426195" // Production ad unit

        case .banner:
            if Configuration.isDebug {
                return "ca-app-pub-3940256099942544/2934735716" // Test Unit
            }
              
            return "ca-app-pub-6202941020778268/7581593738" // Production ad unit
            
        case .appopen:
            if Configuration.isDebug {
                return "ca-app-pub-3940256099942544/5662855259" // Test Unit
            }
              
            return "ca-app-pub-6202941020778268/9788216951" // Production ad unit

        }
    }
}




