//
//  Validation.swift
//  ReelsSaver
//
//  Created by Naveen Rana on 16/08/22.
//

import Foundation


struct ValidationResult {
    var success: Bool
    var error: String?
}

struct Validation {
    
    func isValidUrl(_ url: String) -> Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: url, options: [], range: NSRange(location: 0, length: url.utf16.count)) {
            // it is a link, if the match covers the whole string
            return true
           // return match.range.length == url.utf16.count
        } else {
            return false
        }
    }
}
