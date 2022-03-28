//
//  ScheduleViewObject.swift
//  ATInterview
//
//  Created by JerryLo on 2022/3/26.
//

import Foundation

struct UiScheduleList: Codable {
    let startToEndTime: String
    let scheduleList: [UiSchedule]
}

struct UiSchedule: Codable {
    let weekday: String
    let timestamp: Int
    let cellTimeList: [UiCellTime]    
}

struct UiCellTime: Codable {
    let time: String
    let isAvailable: Bool
}

