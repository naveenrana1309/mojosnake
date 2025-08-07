//
//  OnLoadModifier.swift
//  DuckworthLewis
//
//  Created by Naveen Rana on 07/12/22.
//

import Foundation
import SwiftUI


struct OnLoadModifier: ViewModifier {
    
    @State private var viewDidLoad = false
    let action: (() -> Void)?
    
    func body(content: Content) -> some View {
        content.onAppear {
            if viewDidLoad == false {
                viewDidLoad = true
                action?()
            }
        }
    }
}
