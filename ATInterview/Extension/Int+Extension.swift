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

        return dateFormatter.string(from: date)
    }

}
