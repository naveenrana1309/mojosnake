//
//  Optional+Extension.swift
//  ReelsSaver
//
//  Created by Naveen Rana on 17/08/22.
//

import Foundation


extension Optional where Wrapped == String {
    
    var validString: String {
        return self ?? ""
    }
    
}

extension Optional {
    var isValid: Bool {
        return self != nil
    }
}
