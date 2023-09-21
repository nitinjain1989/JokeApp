//
//  APIService.swift
//  JokeApp
//
//  Created by Nitin Jain on 21/09/23.
//

import Foundation

protocol APIServicable {
    @discardableResult
    func getData<T: Decodable, E:Errorable>(_ request: Requestable,type: T.Type, errorType: E.Type, then completionHandler: @escaping ((Result<T, Error>) -> Void)) -> URLSessionDataTask?
}

final class APIService: APIServicable {
    
    private let networkSession: NetworkSession
    
    init(networkSession: NetworkSession) {
        self.networkSession = networkSession
    }
    
    
    func getData<T: Decodable, E:Errorable>(_ request: Requestable, type: T.Type, errorType: E.Type, then completionHandler: @escaping ((Result<T, Error>) -> Void)) -> URLSessionDataTask? {
        return self.networkSession.call(request, errorType: errorType) { result in
            
            switch result {
            case .success(let data):
                let result = self.parse(toType: T.self, data: data)
                completionHandler(result)
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
  
    

    private func parse<T: Decodable>(toType: T.Type, data: Data) -> Result<T, Error> {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedData)
        }
        catch let error as NSError {
            return .failure(error)
        }
    }
}
