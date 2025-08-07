//
//  UIDevice+Extension.swift
//  ReelsSaver
//
//  Created by Naveen Rana on 02/11/22.
//

import Foundation
import UIKit

extension UIDevice {
    
    /// Checks if the current device that runs the app is xCode's simulator
    static func isSimulator() -> Bool {
        #if targetEnvironment(simulator)
            return true
        #else
            return false
        #endif
    }
}
