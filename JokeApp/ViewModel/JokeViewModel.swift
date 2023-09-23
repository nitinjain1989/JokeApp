//
//  JokeViewModel.swift
//  JokeApp
//
//  Created by Nitin Jain on 21/09/23.
//

import Foundation

protocol JokeViewModelDelegate: AnyObject {
    
    func updateList()
    func addJoke(indexPath: IndexPath)
    func removeJoke(indexPaths: [IndexPath])
    func showError(message: String)
}

protocol JokeViewModelType {
    var jokes: [JokeModel] { get }
    var delegate: JokeViewModelDelegate? { get set }
    func fetchJoke()
}


final class JokeViewModel: JokeViewModelType {
    
    let maxJokeCount = 10
    let fetchJokeAfter: Double = 60 //seconds
    var jokes: [JokeModel] = []
    weak var delegate: JokeViewModelDelegate? //Two way communication
    private let service: JokeServicable
    private let dispatchQueue: DispatchQueueType
    private let repository: JokeRepository
    
    init(service: JokeServicable,
         dispatchQueue: DispatchQueueType = DispatchQueue.main,
         repository: JokeRepository = JokeDataRepository()) {
        self.service = service
        self.dispatchQueue = dispatchQueue
        self.repository = repository
    }
    
    func fetchJoke() {
        
        if let jokes = repository.getAll(), !jokes.isEmpty { // Fetch Data from DB
            self.jokes = jokes.reversed()
            fetchAfterSomeTime()
            delegate?.updateList()
        } else {
            fetchFromServer()
        }
    }
    
    func fetchFromServer() {
        service.getJoke { [weak self] result in
           
            switch result {
            case .success(let joke):
                self?.handleAPISuccess(joke: joke)
            case .failure(let error):
                self?.handleAPIFailure(error: error as! Errorable)
            }
        }
    }
    
    func fetchAfterSomeTime() {
        dispatchQueue.asyncAfter(time: .now() + fetchJokeAfter) { [weak self] in
            self?.fetchFromServer()
        }
    }
}

extension JokeViewModel {
    
    private func handleAPISuccess(joke: JokeModel) {
        
        if jokes.isEmpty {
            jokes.append(joke)
        } else {
            
            if jokes.count >= maxJokeCount { // Remove last row if jokes count reached at max
                let indexPath = IndexPath(row: jokes.count - 1, section: 0)
                let joke = jokes.removeLast()
                repository.delete(time: joke.time) //Remove from DB
                delegate?.removeJoke(indexPaths: [indexPath])
            }
            //new Row Insert at Top
            repository.create(jokeModel: joke) // Insert in DB
            jokes.insert(joke, at: 0)
        }
        
        let indexPath = IndexPath(row: 0, section: 0)
        delegate?.addJoke(indexPath: indexPath)
        
        fetchAfterSomeTime()
    }
    
    private func handleAPIFailure(error: Errorable) {
        delegate?.showError(message: error.errorDescription)
    }
}
