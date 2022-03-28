//
//  Int+Extension.swift
//  ATInterview
//
//  Created by JerryLo on 2022/3/26.
//

import Foundation

extension Int {
    func timestampDateStr(dateFormat: String = "yyyy-MM-dd") -> String {
        let timeInterval = TimeInterval(self)
        let date: Date = Date(timeIntervalSince1970: timeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale = Locale.current
//        dateFormatter.calendar = Calendar(identifier: .republicOfChina)

        return dateFormatter.string(from: date)

    }
    
    var dayNumberOfWeek: String {
        let timeInterval = TimeInterval(self)
        let date: Date = Date(timeIntervalSince1970: timeInterval)
        let weekDay = Calendar.current.component(.weekday, from: date)
        
        switch weekDay {
        case 1:
            return "Sun"
        case 2:
            return "Mon"
        case 3:
            return "Tue"
        case 4:
            return "Wed"
        case 5:
            return "Thu"
        case 6:
            return "Fri"
        case 7:
            return "Sat"
        default:
            print("Error fetching days")
            return "Day"
        }
    }
    
    var day: String {
        let timeInterval = TimeInterval(self)
        let date: Date = Date(timeIntervalSince1970: timeInterval)
        let day = Calendar.current.component(.day, from: date)
        
        return String(day)
    }

}
