//
//  ApiEndpoint.swift
//  JokeApp
//
//  Created by Nitin Jain on 21/09/23.
//

import Foundation

protocol ApiEndpointType {
    var host: String { get }
    var path: String { get }
}

struct ApiEndpoint: ApiEndpointType {
    public let host: String
    public let path: String
    
    public init(host: String, path: String) {
        self.host = host
        self.path = path
    }
}

extension ApiEndpoint {
    
    static func endPoint(path: String) -> ApiEndpoint {
        return .init(host: NetworkConstant.BASE_URL, path:  "/" + path)
    }
}
