//
//  ScheduleVM.swift
//  ATInterview
//
//  Created by JerryLo on 2022/3/26.
//

import Foundation
import RxSwift

class ScheduleVM {
    private let disposeBag = DisposeBag()
    private let teachingTime = 30*60
    let getScheduleSubject = PublishSubject<UiScheduleList>()
    
    func getScheduleViewObject(timestamp: Int) {
        let time = (timestamp - Date().daySec).timestampDateStr(dateFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'")

        APIManager.shared.getSchedule(time: time).map { schedule -> UiScheduleList in
            return self.genUiScheduleList(schedule: schedule)
        }.subscribe(onSuccess: { viewObject in
            self.getScheduleSubject.onNext(viewObject)
        }, onFailure: { err in
            print(err)
            self.getScheduleSubject.onError(err)
        }).disposed(by: disposeBag)
    }
    
    func getTimeZoneHint() -> String {
        let localTimeZoneAbbreviation = TimeZone.current.abbreviation() ?? ""
        let localTimeZoneIdentifier = TimeZone.current.identifier
        
        return "* All times listed are in your local timezone: \(localTimeZoneIdentifier) (\(localTimeZoneAbbreviation))"
    }
    
    private func genUiScheduleList(schedule: ScheduleResp) -> UiScheduleList {
        var scheduleList = [UiSchedule]()
        
        schedule.available.forEach {
            var availableTimeList = [String]()
            var cellTimeList = [UiCellTime]()
            let startTimestamp = $0.start.dateStringToUTCTimestamp()
            let endTimestamp = $0.end.dateStringToUTCTimestamp()
            let timestamp = startTimestamp.timestampDateStr(dateFormat: "yyyy-MM-dd").dateStringToUTCTimestamp(dateFormat: "yyyy-MM-dd")
            let weekday = timestamp.dayNumberOfWeek
                                
            for myTimestamp in stride(from: startTimestamp, to: endTimestamp, by: teachingTime) {
                availableTimeList.append(myTimestamp.timestampDateStr(dateFormat: "HH:mm"))
                cellTimeList.append(.init(time: myTimestamp.timestampDateStr(dateFormat: "HH:mm"), isAvailable: true))
            }
            
            if scheduleList.contains(where: {
                return $0.timestamp == timestamp
            }) {
                scheduleList = scheduleList.map { mySchedule -> UiSchedule in
                    if mySchedule.timestamp == timestamp {
                        cellTimeList += mySchedule.cellTimeList
                        return .init(weekday: mySchedule.weekday, timestamp: mySchedule.timestamp, cellTimeList: cellTimeList)
                    }
                    else {
                        return mySchedule
                    }
                }
            }
            else {
                scheduleList.append(.init(weekday: weekday, timestamp: timestamp, cellTimeList: cellTimeList))
            }
            
        }
        
        schedule.booked.forEach {
            var bookedTimeList = [String]()
            var cellTimeList = [UiCellTime]()
            let startTimestamp = $0.start.dateStringToUTCTimestamp()
            let endTimestamp = $0.end.dateStringToUTCTimestamp()
            let timestamp = startTimestamp.timestampDateStr(dateFormat: "yyyy-MM-dd").dateStringToUTCTimestamp(dateFormat: "yyyy-MM-dd")
            let weekday = timestamp.dayNumberOfWeek

            for myTimestamp in stride(from: startTimestamp, to: endTimestamp, by: teachingTime) {
                bookedTimeList.append(myTimestamp.timestampDateStr(dateFormat: "HH:mm"))
                cellTimeList.append(.init(time: myTimestamp.timestampDateStr(dateFormat: "HH:mm"), isAvailable: false))
            }
            
            if scheduleList.contains(where: {
                return $0.timestamp == timestamp
            }) {
                scheduleList = scheduleList.map { mySchedule -> UiSchedule in
                    if mySchedule.timestamp == timestamp {
                        cellTimeList += mySchedule.cellTimeList
                        return .init(weekday: mySchedule.weekday, timestamp: mySchedule.timestamp, cellTimeList: cellTimeList)
                    }
                    else {
                        return mySchedule
                    }
                }
            }
            else {
                scheduleList.append(.init(weekday: weekday, timestamp: timestamp, cellTimeList: cellTimeList))
            }
            
        }
        
        scheduleList = scheduleList.sorted(by: {$0.timestamp < $1.timestamp})

        for myTimestamp in stride(from: scheduleList.first?.timestamp ?? 0, to: scheduleList.last?.timestamp ?? 0, by: Date().daySec) {
            if !scheduleList.contains(where: {
                return $0.timestamp == myTimestamp
            }) {
                let weekday = myTimestamp.dayNumberOfWeek
                scheduleList.append(.init(weekday: weekday, timestamp: myTimestamp, cellTimeList: []))
            }
        }

        scheduleList = scheduleList.sorted(by: {$0.timestamp < $1.timestamp})
        scheduleList = scheduleList.map { mySchedule -> UiSchedule in
            let cellTimeList = mySchedule.cellTimeList.sorted(by: {$0.time.dateStringToUTCTimestamp(dateFormat: "HH:mm") < $1.time.dateStringToUTCTimestamp(dateFormat: "HH:mm")})

            return .init(weekday: mySchedule.weekday, timestamp: mySchedule.timestamp, cellTimeList: cellTimeList)
        }
        
        let startToEndTime = "\(scheduleList.first?.timestamp.timestampDateStr() ?? "") - \(scheduleList.last?.timestamp.timestampDateStr() ?? "")"
        
        return .init(startToEndTime: startToEndTime, scheduleList: scheduleList)
    }

}

