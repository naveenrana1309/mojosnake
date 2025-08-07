//
//  AnalyticsEvent.swift
//  ReelsSaver
//
//  Created by Naveen Rana on 25/10/22.
//

import Foundation

enum AnalyticsEvent {
    
    case gamestart
    case restart
    case gameover
    case highscore(score: String)
    case interstitialAdFailed(error: String)
    case bannerAdFailed(error: String)
    case openAdFailed(error: String)
    


    
    var name: String {
        switch self {
        case .gamestart:
            return "gamestart"
        case .restart:
            return "restart"
        case .gameover:
            return "gameover"
        case .highscore:
            return "highscore"
        case .interstitialAdFailed:
            return "interstitial_ad_load_failed"
        case .bannerAdFailed:
            return "banner_ad_load_failed"
        case .openAdFailed:
            return "open_ad_load_failed"
            
        }
    }
    
    var params: [String: Any]? {
        switch self {
        case .highscore(score: let score):
            return ["score": score]
        case .openAdFailed(let error):
            return ["error": error]
        default:
            return [:]
            
        }
    }
    
}
