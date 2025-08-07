//
//  InterstitialAdView.swift
//  ReelsSaver
//
//  Created by Naveen Rana on 26/10/22.
//

import Foundation
import SwiftUI
import GoogleMobileAds
import WebKit

final class InterstitialAdView: NSObject, FullScreenContentDelegate {

    //Here's the Ad Object we just created
    let interstitialAd = GoogleAdManager.shared.interstitialAd
    //@Binding var isPresented: Bool
    var adUnitId: String
    
    init(adUnitId: AdUnitID) {
       // self._isPresented = isPresented
        self.adUnitId = adUnitId.unitID
        super.init()
        
        interstitialAd?.fullScreenContentDelegate = self //Set this view as the delegate for the ad
    }
    
    //Make's a SwiftUI View from a UIViewController
//    func makeUIViewController(context: Context) -> UIViewController {
//        let view = UIViewController()
//
//        //Show the ad after a slight delay to ensure the ad is loaded and ready to present
//        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2)) {
//            //self.showAd(from: view)
//        }
//
//        return view
//    }
//
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
//
//    }
    
    //Presents the ad if it can, otherwise dismisses so the user's experience is not interrupted
    func showAd() {
        let root = UIApplication.shared.key?.rootViewController

        if let ad = GoogleAdManager.shared.interstitialAd {
            ad.fullScreenContentDelegate = self
            ad.present(from: root!)
        } else {
            print("Ad not ready")
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
        GoogleAdManager.shared.loadInterstitialAd(withAdUnitId: adUnitId)


    }
    
    
//    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
//        print("adDidDismissFullScreenContent called")
//        //Prepares another ad for the next time view presented
//        GoogleAdManager.shared.loadAd(withAdUnitId: adUnitId)
//
//        //Dismisses the view once ad dismissed
//       // isPresented.toggle()
//    }
    
}
