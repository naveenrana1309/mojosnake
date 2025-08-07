//
//  UIApplication+Extension.swift
//  ReelsSaver
//
//  Created by Naveen Rana on 27/10/22.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    var key: UIWindow? {
       return UIApplication
            .shared
            .connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }

    }
}
