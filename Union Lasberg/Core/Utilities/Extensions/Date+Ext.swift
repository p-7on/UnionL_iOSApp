//
//  Date+Ext.swift
//  Union Lasberg
//
//  Created by Simon Puchner on 14.03.25.
//

import Foundation

extension Date {
    
    func filterDayFromDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        
        return formatter.string(from: self)
    }
    
    func filterMonthFromDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "de_DE")
        formatter.dateFormat = "MMM"

        return String(formatter.string(from: self).prefix(3))
    }
    
    func dateShort() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "de_DE")
        formatter.dateFormat = "dd. MMMM"
        
        return formatter.string(from: self)
    }
    
}
