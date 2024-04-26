//
//  Helper.swift
//  Tiny-TodoList-iOS
//
//  Created by Yuetong Guo on 4/24/24.
//

import Foundation

struct Helper{
    
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = TimeZone(secondsFromGMT: 0) //MARK: UTC for now
        return formatter
    }
    
    //Get current Date in String
    static func currentDateStringUTC() -> String {
        return dateFormatter.string(from: Date())
    }
    
    static func stringFromDate(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    static func dateFromString(_ dateString: String) -> Date? {
        dateFormatter.date(from: dateString)
    }

    
    // Utility function to format ISO date strings
    static func formattedDateString(_ isoDateString: String) -> String {
        let parts = isoDateString.split(separator: "T")
        let dateParts = parts[0].split(separator: "-")
        guard dateParts.count == 3 else { return isoDateString }
        
        let year = dateParts[0]
        let month = Int(dateParts[1]) ?? 0
        let day = Int(dateParts[2]) ?? 0
        
        let monthName = DateFormatter().monthSymbols[month - 1]
        return "\(monthName) \(day), \(year)"
    }
}


