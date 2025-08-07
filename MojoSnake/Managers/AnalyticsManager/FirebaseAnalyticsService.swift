//
//  FirebaseAnalyticsService.swift
//  ReelsSaver
//
//  Created by Naveen Rana on 25/10/22.
//

import Foundation
import FirebaseCore
import FirebaseAnalytics


class FirebaseAnalyticsService: AnalyticsService {
    func initializeService() {
        FirebaseApp.configure()
    }
    
    func logEvent(event: AnalyticsEvent) {
        Analytics.logEvent(event.name, parameters: event.params)
    }
    
}
