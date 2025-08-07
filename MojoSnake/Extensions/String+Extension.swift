//
//  String+Extension.swift
//  ReelsSaver
//
//  Created by Naveen Rana on 17/06/23.
//

import Foundation

extension String {
    
    func toJsonDict() -> NSDictionary? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary else {
            return nil
        }
        return jsonObject
    }
}
