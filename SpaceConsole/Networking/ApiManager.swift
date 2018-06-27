//
//  ApiManager.swift
//  MVVMPlayground
//
//  Created by Jerry on 2018/6/13.
//  Copyright © 2018年 ST.Huang. All rights reserved.
//

import Foundation
import Alamofire

protocol BusinessServiceProtocol {
    func fetchParks<T: ResponseProtocol>(offset: Int, limit: Int,
                                         completion: @escaping (_ responseSerialized: T?, _ error: String?) -> ())
}


public class ApiManager: BusinessServiceProtocol {
    static let sharedManager = ApiManager()

    private init() {
//        let configuration = URLSessionConfiguration.default
//        configuration.httpAdditionalHeaders =  SessionManager.defaultHTTPHeaders
//        configuration.timeoutIntervalForRequest = 40
        
//        manager = Alamofire.SessionManager.default
        

//        let serverTrustPolicy = ServerTrustPolicy.pinCertificates(
//            certificates: ServerTrustPolicy.certificatesInBundle(),
//            validateCertificateChain: true,
//            validateHost: true
//        )
    }
    
    //    func post<T: ResponseProtocol>(params: Dictionary<String,Any>?,
    //                                   completion: @escaping (_ responseObject: T?, _ error: String?) -> ()) {
    //
    //
    //        completion(nil, nil)
    //    }
    
    func fetchParks<T: ResponseProtocol>(offset: Int, limit: Int,
                                         completion: @escaping (_ responseSerialized: T?, _ error: String?) -> ()) {

        let taipeiParkRequest = TaipeiParkRouter.fetch(offset: offset, limit: limit)
        let taipeiParkDataSerializer = BaseDataSerializer<T>()
        
        Alamofire.request(taipeiParkRequest).validate().response(responseSerializer: taipeiParkDataSerializer) { dataResponse in
            print(dataResponse)
            if dataResponse.result.isSuccess {
                completion(dataResponse.value, nil)
            }
            else {
                completion(nil, dataResponse.error.debugDescription)
            }
            
        }
        
        
    }
    
}
