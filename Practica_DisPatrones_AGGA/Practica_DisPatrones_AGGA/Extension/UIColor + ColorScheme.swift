//
//  UIColor + ColorScheme.swift
//  Practica_DisPatrones_AGGA
//
//  Created by Alejandro Alberto Gavira García on 22/1/24.
//

import UIKit

extension UIColor {
    
    // HEX Custom Colors
    static let DBOrange = UIColor(hex: "#FF9922")
    static let DBOrangePressed = UIColor(hex: "#F4E10B")
    static let DBYellow = UIColor(hex: "#FFEA00")
    static let DBYellowPressed = UIColor(hex: "#F4E10B")
    static let DBRed = UIColor(hex: "#FF0000")
    static let DBRedPressesd = UIColor(hex: "#F4E10B")
    
    // Method for Hex Colors
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    
}
