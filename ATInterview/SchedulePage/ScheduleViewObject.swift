//
//  ScheduleViewObject.swift
//  ATInterview
//
//  Created by JerryLo on 2022/3/26.
//

import Foundation

struct UiScheduleList {
    let startToEndTime: String
    let scheduleList: [UiSchedule]
}

struct UiSchedule {
    let weekday: String
    let timestamp: Int
    let cellTimeList: [UiCellTime]    
}

struct UiCellTime {
    let time: String
    let isAvailable: Bool
}

