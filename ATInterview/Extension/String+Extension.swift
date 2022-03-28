//
//  String+Extension.swift
//  ATInterview
//
//  Created by JerryLo on 2022/3/26.
//

import Foundation

extension String {
    func dateStringToUTCTimestamp(dateFormat: String = "yyyy-MM-dd'T'HH:mm:ssZ") -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
//        dateFormatter.locale = Locale(identifier: "en-US")
//        dateFormatter.calendar = Calendar(identifier: .republicOfChina)
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = TimeZone(identifier: "UTC")//NSTimeZone(abbreviation: "UTC")

        return Int((dateFormatter.date(from: self) ?? Date()).timeIntervalSince1970)
        
        
        
            // "Jul 23, 2014, 11:01 AM" <-- looks local without seconds. But:

            // "2014-07-23 11:01:35 -0700" <-- same date, local, but with seconds
//        formatter.timeZone = NSTimeZone(abbreviation: "UTC")
//        let utcTimeZoneStr = formatter.stringFromDate(date)

    }
    
//    func getDayOfWeekString() -> String? {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd"
//        if let todayDate = formatter.date(from: self) {
//            let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
//            let myComponents = myCalendar.components(.Weekday, fromDate: self)
//            let weekDay = myComponents.weekday
//            switch weekDay {
//            case 1:
//                return "Sun"
//            case 2:
//                return "Mon"
//            case 3:
//                return "Tue"
//            case 4:
//                return "Wed"
//            case 5:
//                return "Thu"
//            case 6:
//                return "Fri"
//            case 7:
//                return "Sat"
//            default:
//                print("Error fetching days")
//                return "Day"
//            }
//        } else {
//            return nil
//        }
//    }
}

