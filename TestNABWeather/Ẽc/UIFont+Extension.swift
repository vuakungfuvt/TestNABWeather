//
//  UIFont+Extension.swift
//  GymCalendar
//
//  Created by tnu on 
//  Copyright © 2018 tnu. All rights reserved.
//

import UIKit

extension UIFont {
    // Name of font will be defined according to project
    
    static func regular(size: CGFloat) -> UIFont {
        return UIFont(name: "NunitoSans-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func normal(size: CGFloat) -> UIFont {
        return UIFont(name: "NunitoSans-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    // Name of font will be defined according to project
    static func bold(size: CGFloat) -> UIFont {
        return UIFont(name: "NunitoSans-Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
    
    static func semibold(size: CGFloat) -> UIFont {
        return UIFont(name: "NunitoSans-Semibold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
}
