//
//  Helper.swift
//  Tiny-TodoList-iOS
//
//  Created by Yuetong Guo on 4/24/24.
//

import Foundation

struct Helper {
        
    static var UTCdateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }
            
    static func localDateToUTCString(_ date: Date) -> String {
        return UTCdateFormatter.string(from: date)
    }
    
    // UTC string to Local date
    static func UTCStringToLocalDate(_ dateString: String) -> Date? {
        // UTC string to UTC date
        if let date = UTCdateFormatter.date(from: dateString) {
            print("here")
            let timeZoneOffset = TimeInterval(TimeZone.current.secondsFromGMT(for: date))
            let localDate = date.addingTimeInterval(timeZoneOffset)
            return localDate
            
        }
        return nil
    }
    
    // Utility function to format ISO date strings from UTC string to local string
    static func formattedDateString(_ isoDateString: String) -> String {
        let localDate = UTCStringToLocalDate(isoDateString)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy" // "MMM" for abbreviated month, "dd" for day, "yyyy" for year
        let dateString = dateFormatter.string(from: localDate!)
        return dateString
    }
}


