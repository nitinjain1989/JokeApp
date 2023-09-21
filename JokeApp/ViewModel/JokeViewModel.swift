//
//  JokeViewModel.swift
//  JokeApp
//
//  Created by Nitin Jain on 21/09/23.
//

import Foundation

protocol JokeViewModelType {
    func fetchJoke()
}


final class JokeViewModel: JokeViewModelType {
    
    private let service: JokeServicable
    
    init(service: JokeServicable) {
        self.service = service
    }
    
    func fetchJoke() {
        
        service.getJoke { result in
            
            
        }
    }
    
}
