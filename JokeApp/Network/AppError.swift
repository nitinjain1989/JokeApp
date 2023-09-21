//
//  AppError.swift
//  JokeApp
//
//  Created by Nitin Jain on 21/09/23.
//

import Foundation

protocol Errorable: Error {
   var errorDescription: String { get }
}

public enum AppError: Errorable {
    public var errorDescription: String {
        return ""
    }
    
    case badRequest
    case notFound
    case parsingError

}
