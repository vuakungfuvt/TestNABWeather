//
//  NSMutableData+Extensions.swift
//  xGaming
//
//  Created by LinhTa on 6/8/20.
//

import Foundation

extension NSMutableData {
    func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
