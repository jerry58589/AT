//
//  Date+Extension.swift
//  ATInterview
//
//  Created by JerryLo on 2022/3/28.
//

import Foundation

extension Date {
    var daySec: Int {
        return 24*60*60
    }
    
    var weekSec: Int {
        return self.daySec * 7
    }
}
