//
//  Requestable.swift
//  JokeApp
//
//  Created by Nitin Jain on 21/09/23.
//

import Foundation

protocol Requestable {
    var endpoint: ApiEndpointType { get }
    var urlRequest: URLRequest? { get }
    var header: [String: String]? { get }
    var configuration: RequestConfigurable { get }
    var method: HTTPMethod { get }
    var queryItems: [String: Any]? { get }
    var params: [String: Any]? { get}
}

extension Requestable {
    var configuration: RequestConfigurable {
        return RequestConfiguration()
    }
}

extension Requestable {
    
    /// Converts a Request instance to an URLRequest instance.
    var url: URL? {
        
        var components = URLComponents(string: self.endpoint.host)!
        components.path = self.endpoint.path
        
        if let queryItems = self.queryItems {
            
            components.queryItems = queryItems.map {
                URLQueryItem(name: $0, value: "\($1)")
            }
        }
        return components.url
    }
    
    func createURLRequest() -> (request: URLRequest, headers: [String: String], params: [String: Any]?)? {
        // URL object is not nill for empty URL string
        guard let url = self.url, !url.absoluteString.isEmpty else { return nil }
        
        var urlRequest = URLRequest(url: url,
                                    cachePolicy: self.configuration.cachePolicy)
        
        urlRequest.timeoutInterval = self.configuration.timeoutInterval
        urlRequest.httpMethod = self.method.rawValue
        
        var newHeader:[String: String] = [:]
        newHeader.merge(self.header ?? [:]) {(_,new) in new}
        let res: (request: URLRequest, headers: [String: String], params: [String: Any]?) = (urlRequest, newHeader, self.params)
        return res
    }
    
    var urlRequest: URLRequest? {
        let urlRequestHeaderParam = createURLRequest()
        
        guard var urlRequest = urlRequestHeaderParam?.request else {
            return nil
        }
        
        let params: [String: Any]? = urlRequestHeaderParam?.params
        let newHeader: [String: String] = urlRequestHeaderParam?.headers ?? [:]
        
        for (key,value) in newHeader {
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        // If http body is already present, we override it.
        if let params = params, !params.isEmpty {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        }
        
        return urlRequest
    }
}
