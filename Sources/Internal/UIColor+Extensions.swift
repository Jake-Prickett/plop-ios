//
//  UIColor+Extensions.swift
//  PLOP
//
//  Created by Jake Prickett on 12/27/19.
//  Copyright © 2019 Jake Prickett. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let darkModeBlue = UIColor.rgb(red: 99, green: 182, blue: 252)
    
    static let darkModeGreen = UIColor.rgb(red: 160, green: 217, blue: 117)
    
    static let darkModeRed = UIColor.rgb(red: 225, green: 129, blue: 112)
    
    static let darkModePurple = UIColor.rgb(red: 167, green: 157, blue: 247)
    
    static let darkModeBackground = UIColor.rgb(red: 41, green: 42, blue: 48)
}
