//
//  AppOpenAdView.swift
//  ReelsSaver
//
//  Created by Naveen Rana on 09/12/22.
//



import Foundation
import SwiftUI
import GoogleMobileAds
import WebKit

final class AppOpenAdView: NSObject, FullScreenContentDelegate {

    //Here's the Ad Object we just created
    let appOpenAd = GoogleAdManager.shared.appOpenAd
    var adUnitId: String
    
    init(adUnitId: AdUnitID) {
        self.adUnitId = adUnitId.unitID
        super.init()
        appOpenAd?.fullScreenContentDelegate = self //Set this view as the delegate for the ad
    }
    
    
    //Presents the ad if it can, otherwise dismisses so the user's experience is not interrupted
    func showAd() {
        let root = UIApplication.shared.key?.rootViewController

        if let ad = GoogleAdManager.shared.appOpenAd {
            ad.fullScreenContentDelegate = self
            ad.present(from: root!)
        } else {
            DLog("Ad not ready")
            //self.isPresented.toggle()
        }
    }
    
    
    //MARK: Delegates of Interstitial ads
    
    func ad(_ ad: FullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        DLog("ad Failed /\(error)")
    }
    
    func adWillDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        DLog("adWillDismissFullScreenContent")
    }
    
    func adDidDismissFullScreenContent(_ ad: FullScreenPresentingAd) {
        DLog("adDidDismissFullScreenContent")
        GoogleAdManager.shared.loadOpenAppAd(withAdUnitId: adUnitId)


    }
    
    
}
