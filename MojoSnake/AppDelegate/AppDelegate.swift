//
//  AppDelegate.swift
//  ReelsSaver
//
//  Created by Naveen Rana on 19/11/22.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        initializeSDKS()
        registerPushNotifications(application: application)

        return true

    }
    
    
    private func initializeSDKS() {
        AnalyticsManager.shared.add(service: FirebaseAnalyticsService())
        AnalyticsManager.shared.initializeService()

        GoogleAdManager.shared.initializeSDK()
    }
    
}
