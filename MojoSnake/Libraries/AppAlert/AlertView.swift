//
//  AlertView.swift
//  ReelsSaver
//
//  Created by Naveen Rana on 22/10/22.
//

import Foundation

import SwiftUI

extension View {
    func alert(message: Binding<AlertMessage?>, buttonTitle: String = "OK") -> some View {
        
        return alert(message.wrappedValue?.title ?? "" , isPresented: .constant(message.wrappedValue != nil)) {
            Button(buttonTitle) {
                message.wrappedValue = nil
            }
        } message: {
            Text(message.wrappedValue?.message ?? "")
            
        }
    }
    
    
}

struct AlertMessage {
    
    var title: String
    var message: String
    
    init(type: AlertMessageType) {
        self.title = type.title
        self.message = type.message
    }
    init?(error: Error?) {
        if error != nil {
            if let localizedError = error as? AppError {
                self.title = localizedError.title
                self.message = localizedError.errorDescription ?? ""
            }
            else {
                self.title = AppInfo.appname
                self.message = error!.localizedDescription
                
            }
            
        }
        else {
            return nil

        }
    }
}



