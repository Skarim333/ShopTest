//
//  UIColor + Extension.swift
//  ShopTest
//
//  Created by Карим Садыков on 28.08.2022.
//

import Foundation
import UIKit

extension UIColor {
    
    static func mainWhite() -> UIColor {
        return #colorLiteral(red: 0.9727925658, green: 0.9729320407, blue: 0.9727620482, alpha: 1)
    }
    
    static func mainGrey() -> UIColor {
        return #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
    }
    
    static func lightGrey() -> UIColor {
        return #colorLiteral(red: 0.7019607843, green: 0.7019607843, blue: 0.7647058824, alpha: 1)
    }
    
    static func mediumGrey() -> UIColor {
        return #colorLiteral(red: 0.6196078431, green: 0.6196078431, blue: 0.6196078431, alpha: 1)
    }
    
    static func darkGrey() -> UIColor {
        return #colorLiteral(red: 0.2078431373, green: 0.2117647059, blue: 0.3333333333, alpha: 1)
    }
    
    static func mainOrange() -> UIColor {
        return #colorLiteral(red: 1, green: 0.431372549, blue: 0.3058823529, alpha: 1)
    }
    
    static func mainBrown() -> UIColor {
        return #colorLiteral(red: 0.4666666667, green: 0.1764705882, blue: 0.01176470588, alpha: 1)
    }
    
    static func mainBlue() -> UIColor {
        return #colorLiteral(red: 0.003921568627, green: 0, blue: 0.2078431373, alpha: 1)
    }
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
}

extension UIImage {
    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        
        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }

        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        context.rotate(by: CGFloat(radians))

        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
