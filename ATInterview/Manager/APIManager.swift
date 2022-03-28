//
//  APIManager.swift
//  ATInterview
//
//  Created by JerryLo on 2022/3/26.
//

import Foundation
import Alamofire
import RxSwift

class APIManager {

    static let shared = APIManager()
    
    func getSchedule(time: String) -> Single<ScheduleResp> {
        var params = [String: AnyObject]()
        params["started_at"] = time as AnyObject//"2022-04-02T16:00:00.000Z" as AnyObject
        
        return task(apiType: .OPENAPI_GET_SCHEDULE, params: params).flatMap { (data) -> Single<ScheduleResp> in
            return APIManager.handleDecode(ScheduleResp.self, from: data)
        }

    }

    public enum DecodeError: Error, LocalizedError {
        case dataNull
        public var errorDescription: String? {
            switch self {
            case .dataNull:
                return "Data Null"
            }
        }
    }

    private static func handleDecode<T>(_ type: T.Type, from data: Data?) -> Single<T> where T: Decodable {
        if let strongData = data {
            do {
                let toResponse = try JSONDecoder().decode(T.self ,from: strongData)
                return Single<T>.just(toResponse)
            } catch {
                return Single.error(error)
            }
        } else {
            return Single.error(DecodeError.dataNull)
        }
    }

    private func task(apiType: ApiType, params: [String: AnyObject]? = nil) -> Single<Data?> {
        return Single<Data?>.create { (singleEvent) -> Disposable in
            Alamofire.request(apiType.host + apiType.path, method: apiType.method, parameters: params, encoding: apiType.encoding, headers: apiType.headers).responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
                    if let jsonData = response.data , let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                       print("JSONString = " + JSONString)
                    }
                    singleEvent(.success(response.data))
                case .failure(let error):
                    singleEvent(.failure(error))
                }
                
            })
            return Disposables.create()
        }

    }
}

extension APIManager {
    
    private enum ApiType {
        case OPENAPI_GET_SCHEDULE
        
        var host: String {
            switch self {
            case .OPENAPI_GET_SCHEDULE:
                return "https://en.amazingtalker.com"
            }
        }
        
        var path: String {
            switch self {
            case .OPENAPI_GET_SCHEDULE:
                return "/v1/guest/teachers/amy-estrada/schedule"
            }
        }
        
        var method: HTTPMethod {
            switch self {
            case .OPENAPI_GET_SCHEDULE:
                return .get
            }
        }
        
        var headers: [String: String]? {
            switch self {
            case .OPENAPI_GET_SCHEDULE:
                return nil
            }
        }
        
        var encoding: ParameterEncoding {
            switch self {
            case .OPENAPI_GET_SCHEDULE:
                return URLEncoding.default
            }
        }
    }

}
