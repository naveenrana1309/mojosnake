//
//  GoogleAdManager.swift
//  ReelsSaver
//
//  Created by Naveen Rana on 26/10/22.
//

import Foundation
import GoogleMobileAds


class GoogleAdManager {
    
    private init() {}
    static let shared = GoogleAdManager()
    var interstitialAd: InterstitialAd?
    var appOpenAd: AppOpenAd?

    let interstitialAdFrequency = Configuration.isDebug ? 1 : 4
    let openAdFrequency = Configuration.isDebug ? 1 : 7

    let showAds: Bool = Configuration.isDebug ? true : true
    
    func initializeSDK() {
        if showAds == false {
            return ()
        }
        MobileAds.shared.requestConfiguration.testDeviceIdentifiers = ["SIMULATOR"]

        MobileAds.shared.start { status in
            self.loadInterstitialAd(withAdUnitId: AdUnitID.interstitialAd.unitID)
            self.loadOpenAppAd(withAdUnitId: AdUnitID.appopen.unitID)
        }
    }
    
    func loadInterstitialAd(withAdUnitId id: String) {
        let req: Request = Request()
        InterstitialAd.load(with: id, request: req) { interstitialAd, err in
            if let err = err {
                AnalyticsManager.shared.logEvent(event: .interstitialAdFailed(error: err.localizedDescription))
                DLog("Failed to load ad with error: \(err)")
                return
            }
            DLog("Succesfully load GADInterstitialAd ")
            self.interstitialAd = interstitialAd
        }
    }
    func loadOpenAppAd(withAdUnitId id: String) {
        let req: Request = Request()
        AppOpenAd.load(with: id, request: req) { openAppAd, err in
            if let err = err {
                AnalyticsManager.shared.logEvent(event: .openAdFailed(error: err.localizedDescription))
                DLog("Failed to load ad with error: \(err)")
                return
            }
            DLog("Succesfully load openAppAd")
            self.appOpenAd = openAppAd
        }
    }
}


