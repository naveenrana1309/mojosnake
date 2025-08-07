//
//  AppDelegate+PushNotification.swift
//  ReelsSaver
//
//  Created by Naveen Rana on 19/11/22.
//

import Foundation
import FirebaseMessaging
import UIKit


extension AppDelegate: MessagingDelegate, UNUserNotificationCenterDelegate {
    
    func registerPushNotifications(application: UIApplication) {
        
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { granted, error in
            if granted {
                DLog("Successfully Granted the Push notification")
            }
            else {
                DLog("error occured in request push notification \(error)")
            }
        }
        
        application.registerForRemoteNotifications()
        
    }
    
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        
        DLog("did receive push notifications \(userInfo)")
        Messaging.messaging().appDidReceiveMessage(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    
    //MARK: UserNotifications
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        DLog("User notifications will present \(userInfo)")
        
        
        Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // Change this to your preferred presentation option
        completionHandler([[.banner, .badge, .sound]])
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map{ data in String(format: "%02.2hhx", data) }.joined()
        
        DLog("didRegisterForRemoteNotificationsWithDeviceToken \(token) ")
        Messaging.messaging().apnsToken = deviceToken;
        
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        DLog("didFailToRegisterForRemoteNotificationsWithError \(error)")
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        
        DLog("User notifications didReceive \(userInfo)")
        Messaging.messaging().appDidReceiveMessage(userInfo)
        
        completionHandler()
    }
    
    
    //MARK: FCM Delegates
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        let deviceToken:[String: String] = ["token": fcmToken ?? ""]
        DLog("FCM Device token: \(deviceToken)") // This token can be used for testing notifications on FCM
        Messaging.messaging().subscribe(toTopic: "DLSCricket")
        
    }
}
