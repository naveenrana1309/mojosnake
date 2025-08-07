//
//  Configuration.swift
//  ReelsSaver
//
//  Created by Naveen Rana on 25/10/22.
//

import Foundation


class Configuration {
    
    static var isDebug: Bool {
#if DEBUG
        return true
#endif
        return false
    }
}
