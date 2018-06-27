//
//  TaipeiModel.swift
//  MVVMPlayground
//
//  Created by Jerry on 2018/6/5.
//  Copyright © 2018年 ST.Huang. All rights reserved.
//

import Foundation

protocol ResponseProtocol: Decodable {
    var returnCode: String {get set}
    var message: String {get set}
}

struct TaipeiApiResponse: ResponseProtocol {
    var returnCode: String
    var message: String
    
    let offset: Int
    let limit: Int
    let count: Int
    let parks: [Park]?
    
}

extension TaipeiApiResponse {
    
    private enum TaipeiApiResponseResultCodingKeys: String , CodingKey {
        case statusCode
        case message
        case result
        case offset
        case limit
        case count
        case parks = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TaipeiApiResponseResultCodingKeys.self)
        let response = try container.nestedContainer(keyedBy: TaipeiApiResponseResultCodingKeys.self, forKey: .result)
        offset = try response.decode(Int.self, forKey: .offset)
        limit = try response.decode(Int.self, forKey: .offset)
        count = try response.decode(Int.self, forKey: .offset)
        parks = try response.decode([Park].self, forKey: .parks)
        returnCode = "201"
        message = "test success"
    }
}

struct Park {
    let id: String
    let parkName: String
    let name: String
    let yearBuilt: String
    let openTime: String
    let image: String
    let introduction: String
}

extension Park: Decodable {
    private enum ParkCodingKeys: String , CodingKey {
        case id = "_id"
        case parkName = "ParkName"
        case name = "Name"
        case yearBuilt = "YearBuilt"
        case openTime = "OpenTime"
        case image = "Image"
        case introduction = "Introduction"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ParkCodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        parkName = try container.decode(String.self, forKey: .parkName)
        name = try container.decode(String.self, forKey: .name)
        yearBuilt = try container.decode(String.self, forKey: .yearBuilt)
        openTime = try container.decode(String.self, forKey: .openTime)
        image = try container.decode(String.self, forKey: .image)
        introduction = try container.decode(String.self, forKey: .introduction)
    }
}
