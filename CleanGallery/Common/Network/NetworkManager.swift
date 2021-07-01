//
//  NetworkManager.swift
//  CleanGallery
//
//  Created by Naeem Paracha on 01/07/2021.
//

import PromiseKit
import Moya

protocol GeneralAPI {
    static func callApi<T: TargetType, U: Decodable>(_ target: T, dataReturnType: U.Type) -> Promise<U>
}

struct NetworkManager: GeneralAPI {
    
    /// Generic function to call API endpoints using moya and decodable protocol
    ///
    ///   - Parameters:
    ///   - target: The network moya target endpoint to call
    ///   - dataReturnType: The typpe of data that is expected to parse from endpoint response
    ///   - Returns: A promise containing the dataReturnType set in function params
    static func callApi<Target: TargetType, ReturnedObject: Decodable>(_ target: Target, dataReturnType: ReturnedObject.Type) -> Promise<ReturnedObject> {
        
        let provider = MoyaProvider<Target>(plugins: [CachePolicyPlugin()])
        
        return Promise { data in
            provider.request(target) { result in
                switch result {
                case let .success(response):
                    do {
                        let successfulRes = try response.filterSuccessfulStatusCodes()
                        let results = try successfulRes.map(ReturnedObject.self)
                        data.fulfill(results)
                    } catch {
                        data.reject(error)
                    }
                case let .failure(error):
                    data.reject(error)
                }
            }
        }
    }
}
