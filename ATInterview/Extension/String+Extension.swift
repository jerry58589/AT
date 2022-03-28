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
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = TimeZone(identifier: "UTC")

        return Int((dateFormatter.date(from: self) ?? Date()).timeIntervalSince1970)
    }
}

