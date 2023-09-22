//
//  JokeViewModel.swift
//  JokeApp
//
//  Created by Nitin Jain on 21/09/23.
//

import Foundation

protocol JokeViewModelDelegate: AnyObject {
    
    func addJoke(indexPath: IndexPath)
    func removeJoke(indexPath: IndexPath)
}

protocol JokeViewModelType {
    var jokes: [JokeModel] { get }
    var delegate: JokeViewModelDelegate? { get set }
    func fetchJoke()
}


final class JokeViewModel: JokeViewModelType {
    
    let maxJokeCount = 10
    var jokes: [JokeModel] = []
    weak var delegate: JokeViewModelDelegate?
    private let service: JokeServicable
    
    init(service: JokeServicable) {
        self.service = service
    }
    
    func fetchJoke() {
        
        service.getJoke { [weak self] result in
           
            switch result {
            case .success(let joke):
                self?.handleAPISuccess(joke: joke)
            case .failure(let error):
                self?.handleAPIFailure(error: error)
            }
        }
    }
}

extension JokeViewModel {
    
    private func handleAPISuccess(joke: JokeModel) {
        
        if jokes.isEmpty {
            jokes.append(joke)
        } else {
            
            if jokes.count == maxJokeCount { // Remove last row if jokes count reached at max
                let indexPath = IndexPath(row: jokes.count - 1, section: 0)
                jokes.removeLast()
                delegate?.removeJoke(indexPath: indexPath)
                
            }
            //Row Insert at Top
            jokes.insert(joke, at: 0)
        }
        
        let indexPath = IndexPath(row: 0, section: 0)
        delegate?.addJoke(indexPath: indexPath)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 30 , execute:  DispatchWorkItem { [weak self] in
            self?.fetchJoke()
        })
    }
    
    private func handleAPIFailure(error: Error) {
        //TODO: Handle API Error
    }
    
}
