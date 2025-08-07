//
//  Global.swift
//  MojoSnake
//
//  Created by Naveen Rana on 07/08/25.
//

import Foundation


func DLog(_ message: Any, function: String = #function) {

    #if DEBUG
        print("\(Date()) \(function): \(message)")
    #endif
}
