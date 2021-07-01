//
//  CachePolicyPlugin.swift
//  CleanGallery
//
//  Created by Naeem Paracha on 01/07/2021.
//

import Moya

protocol CachePolicyGettableType {
    var cachePolicy: URLRequest.CachePolicy? { get }
}

final class CachePolicyPlugin: PluginType {
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard let policyGettable = target as? CachePolicyGettableType, let policy = policyGettable.cachePolicy else {
            return request
        }

        var mutableRequest = request
        mutableRequest.cachePolicy = policy

        return mutableRequest
    }
}
