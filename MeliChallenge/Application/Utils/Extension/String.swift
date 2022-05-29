//
//  String.swift
//  MeliChallenge
//
//  Created by Mayerly Rios on 27/05/22.
//

import Foundation

extension String {
    
    func changeHttpUrl() -> String {
        return self.replacingOccurrences(of: "http://", with: "https://")
    }
    
    func formatPrice() -> String {
        var text = self
        text = text.replacingOccurrences(of: ",", with: ".")
        let formater = NumberFormatter()
        formater.groupingSeparator = "."
        formater.decimalSeparator = ","
        formater.usesGroupingSeparator = true
        formater.usesSignificantDigits = false
        formater.maximumFractionDigits = 0
        formater.numberStyle = .decimal
        return "$ "+formater.string(from: Double( (text != "") ? text : "0" )! as NSNumber )!
    }
}
