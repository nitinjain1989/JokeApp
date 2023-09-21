//
//  JokeService.swift
//  JokeApp
//
//  Created by Nitin Jain on 21/09/23.
//

import Foundation

enum JokeEndPoint: Requestable {
    var header: [String : String]? {
        return nil
    }
    
    var queryItems: [String : Any]? {
        return nil
    }
    
    var params: [String : Any]? {
        nil
    }
    
    case getJoke
    
    var path: String {
        
        switch self {
        case .getJoke:
            return "api"
        }
    }
    
    var endpoint: ApiEndpointType {
        return ApiEndpoint.endPoint(path: self.path)
    }
    
    var method: HTTPMethod {
        return .GET
    }
}

protocol JokeServicable {
    func getJoke(completionHandler: @escaping ((Result<String, Error>) -> Void))
}

final class JokeService: JokeServicable {
    
    private let apiService: APIServicable
    
    init(apiService: APIServicable) {
        self.apiService = apiService
    }
    
    func getJoke(completionHandler: @escaping ((Result<JokeModel, Error>) -> Void)) {
        let endPoint = JokeEndPoint.getJoke
        apiService.getString(endPoint, errorType: AppError.self) { result in
            
            switch result {
            case .success(let joke):
                completionHandler(.success(JokeModel(joke: joke)))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}

