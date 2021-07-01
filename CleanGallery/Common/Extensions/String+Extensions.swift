//
//  String+Extensions.swift
//  CleanGallery
//
//  Created by Naeem Paracha on 01/07/2021.
//

import Foundation

extension String {
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
