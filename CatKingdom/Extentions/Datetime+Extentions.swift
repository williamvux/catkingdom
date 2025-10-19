//
//  Datetime+Extentions.swift
//  CatKingdom
//
//  Created by William on 19/10/25.
//

import Foundation

extension Date {
    enum DateFormat: String {
        case yyyyMMddHHmmss = "yyyy-MM-dd HH:mm:ss"
        case yyyyMMdd = "yyyy-MM-dd"
        case yyyyMM = "yyyy-MM"
        case hma = "h:mm a"
        case hm = "HH:mm"
        case mmmddyyyy = "MMM dd, yyyy"
        case mmmdd = "MMM dd"
        case eeedd = "EEE dd"
        case yyyymmdd = "yyyyMMdd"
    }
    
    func formatted(with format: DateFormat = .yyyyMMddHHmmss) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: self)
    }
    
    static var currentCalendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .autoupdatingCurrent
        return calendar
    }
    
    var day: Int {
        return Date.currentCalendar.component(.day, from: self)
    }
    
    var month: Int {
        return Date.currentCalendar.component(.month, from: self)
    }
    
    var year: Int {
        return Date.currentCalendar.component(.year, from: self)
    }
    
    var hour: Int {
        return Date.currentCalendar.component(.hour, from: self)
    }
    
    var minute: Int {
        return Date.currentCalendar.component(.minute, from: self)
    }
    
    var second: Int {
        return Date.currentCalendar.component(.second, from: self)
    }
}
