//
//  AnalyticsManager.swift
//  ReelsSaver
//
//  Created by Naveen Rana on 25/10/22.
//

import Foundation

class AnalyticsManager: AnalyticsService {
    
    private init(){}
    
    
    static let shared = AnalyticsManager()
    private(set) var services = [AnalyticsService]()

     
        
    func add(service: AnalyticsService) {
        self.services.append(service)
    }
    
    func initializeService() {
        for service in services {
            service.initializeService()
        }
    }
    
    func logEvent(event: AnalyticsEvent) {
        for service in services {
            service.logEvent(event: event)
        }

    }
    
}

enum AnalyticsType {
    case firebase
    case google
}

