//
//  NetworkService.swift
//  CleanGallery
//
//  Created by Naeem Paracha on 01/07/2021.
//

import Foundation
import Moya

enum NetworkService{
    case getPhotos(page: Int)
}

extension NetworkService: TargetType, CachePolicyGettableType{
    
    var cachePolicy: URLRequest.CachePolicy? {
        return .useProtocolCachePolicy
    }
    
    var baseURL: URL {
        URL(string: "https://pixabay.com/api/?key=22314671-c97d6b45dee3b586801cd1584&q=flowers&image_type=photo&pretty=true&per_page=200")!
    }
    
    var path: String {
        switch self {
        case .getPhotos:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPhotos:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".utf8Encoded
    }
    
    var task: Task {
        switch self {
        case .getPhotos(let page):
            var parameters = Dictionary<String, Int>()
            parameters["page"] = page
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}

