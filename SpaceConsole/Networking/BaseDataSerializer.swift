//
//  TaipeiParkDataSerializer.swift
//  MVVMPlayground
//
//  Created by Jerry on 2018/6/13.
//  Copyright © 2018年 ST.Huang. All rights reserved.
//

import Foundation
import Alamofire

struct BaseDataSerializer<T:ResponseProtocol>: DataResponseSerializerProtocol {

    enum TaipeiParkDataSerializerError: Error {
        case InvalidData
    }
    
    var serializeResponse: (URLRequest?, HTTPURLResponse?, Data?, Error?) -> Alamofire.Result<T> {
        return { (request, response, data, error) in
            if let error = error {
                return .failure(error)
            }
            
            guard let data = data, data.count > 0 else {
                return .failure(AFError.ResponseSerializationFailureReason.inputDataNil as! Error)
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                if #available(iOS 10.0, *) {
                    jsonDecoder.dateDecodingStrategy = .iso8601
                }
                let responseSerialized = try jsonDecoder.decode(T.self, from: data)
                
                return .success(responseSerialized)
            } catch {
                return .failure(error)
            }
            
        }
    }
    
}
