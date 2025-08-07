//
//  BannerAdView.swift
//  ReelsSaver
//
//  Created by Naveen Rana on 27/10/22.
//

import Foundation

import SwiftUI
import GoogleMobileAds
import UIKit

struct BannerAdView: UIViewControllerRepresentable  {

    
    
    let adUnitId: String

    init(adUnitId: AdUnitID) {
        self.adUnitId = adUnitId.unitID
     }
    func makeUIViewController(context: Context) -> UIViewController {
        if GoogleAdManager.shared.showAds == false {
            return UIViewController()
        }

        let view = BannerView(adSize: fullWidthPortrait(height: 300))

        let viewController = UIViewController()
        view.adUnitID = self.adUnitId
        view.rootViewController = viewController
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: AdSizeBanner.size)
        view.load(Request())

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
