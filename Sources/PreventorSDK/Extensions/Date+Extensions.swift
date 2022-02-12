//
//  Date+Extensions.swift
//  PreventorSDK
//
//  Created by Alexander Rodriguez on 1/01/22.
//

import Foundation

extension Date {
    
    func getStringDate(dateFormat: String, locale: Locale = Locale(identifier: "es")) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
    
}
