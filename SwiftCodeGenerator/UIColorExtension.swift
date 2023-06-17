//
//  File.swift
//  SwiftCodeGenerator
//
//  Created by Tifo Audi Alif Putra on 17/06/23.
//

import UIKit

extension UIColor {
    static func hexColor(_ hexString: String?) -> UIColor? {
        guard let hexString else {
            return nil
        }
        
        let r, g, b, a: CGFloat
        var hexColor = hexString
        
        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            hexColor = String(hexString[start...])
        }
        
        if hexColor.count == 8 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            
            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                a = CGFloat(hexNumber & 0x000000ff) / 255
                
                return .init(red: r, green: g, blue: b, alpha: a)
            }
        } else if hexColor.count == 6 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            
            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                g = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                b = CGFloat(hexNumber & 0x000000ff) / 255
                
                return .init(red: r, green: g, blue: b, alpha: 1.0)
            }
        }
        
        return nil
    }
}
