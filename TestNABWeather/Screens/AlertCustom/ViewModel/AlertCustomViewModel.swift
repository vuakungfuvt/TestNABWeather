//
//  AlertCustomViewModel.swift
//  TestNABWeather
//
//  Created by tungphan on 02/04/2022.
//

import UIKit

class AlertCustomViewModel: NSObject {
    
    var content: String = ""
    
    init(content: String) {
        super.init()
        self.content = content
    }

}
