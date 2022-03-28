//
//  Schedule.swift
//  ATInterview
//
//  Created by JerryLo on 2022/3/26.
//

import Foundation

struct ScheduleResp: Codable {

    let available: [Rule]
    let booked: [Rule]

    enum CodingKeys: String, CodingKey {
        case available, booked
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        available = try values.decode([Rule].self, forKey: .available)
        booked = try values.decode([Rule].self, forKey: .booked)

    }
    
//    init(id: Int, time: Int, title: String, description: String, details: [TransactionDetail]) {
//        self.id = id
//        self.time = time
//        self.title = title
//        self.description = description
//        self.details = details
//    }
}

struct Rule: Codable {
    let start: String
    let end: String
}
