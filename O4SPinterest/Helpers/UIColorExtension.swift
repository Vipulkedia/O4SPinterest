//
//  UIColorExtension.swift
//  O4SPinterest
//
//  Created by Vipul Kedia on 25/02/21.
//

import UIKit

extension UIColor {
    
    convenience init(hex: UInt32, alpha: Double = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
    
}
