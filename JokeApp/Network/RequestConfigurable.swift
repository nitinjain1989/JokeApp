//
//  RequestConfigurable.swift
//  JokeApp
//
//  Created by Nitin Jain on 21/09/23.
//

import Foundation

protocol RequestConfigurable {
    
    /// The cache policy of the request
    var cachePolicy: URLRequest.CachePolicy { get set }
    
    /// The timeout interval of the request
    var timeoutInterval: TimeInterval { get set }
}

struct RequestConfiguration: RequestConfigurable {
   
    /// The cache policy of the request. Default is `useProtocolCachePolicy`
    var cachePolicy: URLRequest.CachePolicy
    
    /// The timeout interval of the request. Default is 60.0
    var timeoutInterval: TimeInterval
    
    init(cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy,
                timeoutInterval: TimeInterval = 60.0) {
        self.cachePolicy = cachePolicy
        self.timeoutInterval = timeoutInterval
    }
}
