//
//  NetworkSession.swift
//  JokeApp
//
//  Created by Nitin Jain on 21/09/23.
//

import Foundation

protocol NetworkSession {
   func call<E: Errorable>(_ request: Requestable, errorType: E.Type, then completionHandler: @escaping ((Result<Data, Error>) -> Void)) -> URLSessionDataTask?
}

extension URLSession : NetworkSession {
    
    
    func call<E: Errorable>(_ request: Requestable, errorType: E.Type, then completionHandler: @escaping ((Result<Data, Error>) -> Void)) -> URLSessionDataTask? {
        
        
        guard let urlRequest = request.urlRequest else {
            completionHandler(.failure(AppError.badRequest))
            return nil
        }
        
        let task = self.dataTask(with: urlRequest) {  (data, response, error) in
            
            if let error = error {
                print(error)
                completionHandler(.failure(AppError.badRequest))
                return
            }
            
            let acceptedStatusCode = Set(200...399)
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            
            guard acceptedStatusCode.contains(statusCode) else {
                completionHandler(.failure(AppError.notFound))
                return
            }
            if let data = data {
                completionHandler(.success(data))
            }
            
        }
        task.resume()
        return task
    }
}
