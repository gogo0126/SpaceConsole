//
//  TaipeiParkRouter.swift
//  MVVMPlayground
//
//  Created by Jerry on 2018/6/13.
//  Copyright © 2018年 ST.Huang. All rights reserved.
//

import Foundation
import Alamofire

enum TaipeiParkRouter: URLRequestConvertible {
    
    static let baseURLString = "http://data.taipei/opendata/datalist/apiAccess"

    case fetch(offset: Int, limit: Int)
    
    func asURLRequest() throws -> URLRequest {
        
        let result: (path: String, parameters: Parameters) = {
            switch self {
            case let .fetch(offset, limit) where offset > 0:
                return ("", ["rid":"bf073841-c734-49bf-a97f-3757a6013812",
                             "scope":"resourceAquire",
                             "offset":offset,
                             "limit":limit])
            case .fetch(let offset, let limit):
                return ("", ["rid":"bf073841-c734-49bf-a97f-3757a6013812",
                             "scope":"resourceAquire",
                             "offset":offset,
                             "limit":limit])
            }
        }()
        
        let url = try TaipeiParkRouter.baseURLString.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(result.path))
        return try URLEncoding.default.encode(urlRequest, with: result.parameters)
    }
    
    
}
