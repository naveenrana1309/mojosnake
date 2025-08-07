//
//  View+Extension.swift
//  ReelsSaver
//
//  Created by Naveen Rana on 12/10/22.
//

import Foundation
import SwiftUI



extension View {
    @ViewBuilder func isHidden(_ isHidden: Bool) -> some View {
        if isHidden {
            self.hidden()
        } else {
            self
        }
    }
    
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(OnLoadModifier(action: action))
    }

}
