//
//  ATInterviewTests.swift
//  ATInterviewTests
//
//  Created by JerryLo on 2022/3/26.
//

import XCTest
import RxSwift
import RxBlocking
@testable import ATInterview

class ATInterviewTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetScheduleViewObject() {
        let vm = ScheduleVM()
        vm.getScheduleViewObject(timestamp: Int(Date().timeIntervalSince1970))
        let observable = vm.getScheduleSubject
        let result = observable.toBlocking()

        XCTAssertNotNil(try result.first())
    }
        
    func testGetScheduleApi() {
        let time = (Int(Date().timeIntervalSince1970) - Date().daySec).timestampDateStr(dateFormat: "yyyy-MM-dd'T'HH:mm:ss'Z'")
        var params = [String: AnyObject]()
        params["started_at"] = time as AnyObject
        
        var responseError: Error?
        var responseData: Data?
        var statusCode: Int?

        APIManager.shared.runCommand(apiType: .OPENAPI_GET_SCHEDULE, params: params, completion: { response in
            responseData = response.data
            responseError = response.error
            statusCode = response.response?.statusCode
            
            XCTAssertEqual(statusCode, 200)
            XCTAssertNotNil(responseData)
            XCTAssertNil(responseError)
        })

    }

}
