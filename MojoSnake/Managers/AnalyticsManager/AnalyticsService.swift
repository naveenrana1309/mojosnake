//
//  AnalyticsService.swift
//  ReelsSaver
//
//  Created by Naveen Rana on 25/10/22.
//

import Foundation


protocol AnalyticsService {
    func initializeService()
    func logEvent(event: AnalyticsEvent)
}
