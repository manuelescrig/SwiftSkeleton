//
//  UIColor+Extensions.swift
//  Pods
//
//  Created by Manuel on 10/28/16.
//
//

import Foundation
import UIKit

extension UIColor {
    
    /**
     Get UIColor given a hex value.

     :param: hex     Hex value of the color.
     :alpha: alpha   Alpha for the color.
     */
    convenience init(hex: UInt32, alpha: CGFloat) {
        let red = CGFloat((hex & 0xFF0000) >> 16)/256.0
        let green = CGFloat((hex & 0xFF00) >> 8)/256.0
        let blue = CGFloat(hex & 0xFF)/256.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
