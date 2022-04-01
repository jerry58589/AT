//
//  Schedule.swift
//  ATInterview
//
//  Created by JerryLo on 2022/3/26.
//

import Foundation

struct ScheduleResp: Decodable {
    let available: [Rule]
    let booked: [Rule]
}

struct Rule: Codable {
    let start: String
    let end: String
}
