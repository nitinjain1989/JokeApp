//
//  JokeDataRepository.swift
//  JokeApp
//
//  Created by Nitin Jain on 23/09/23.
//

import Foundation
import CoreData

protocol JokeRepository {
    
    func create(jokeModel: JokeModel)
    func getAll() -> [JokeModel]?
    func delete(time: Double)
}

struct JokeDataRepository: JokeRepository {
    
    func create(jokeModel: JokeModel) {
        let jokeEntity = Joke(context: PersistentStorage.shared.context)
        jokeEntity.joke = jokeModel.joke
        jokeEntity.time = jokeModel.time
        
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [JokeModel]? {
        
        let result =  PersistentStorage.shared.fetchManagedObject(managedObject: Joke.self)
        
        var jokes : [JokeModel] = []

        result?.forEach({ (jokeEntity) in
            jokes.append(jokeEntity.convertToJokeModel())
        })

        return jokes
    }
    
    func delete(time: Double) {
        
        let joke = getJoke(by: time)
        guard let joke = joke else { return }
        
        PersistentStorage.shared.context.delete(joke)
    }
    
    
    private func getJoke(by time: Double) -> Joke? {
        
        let fetchRequest = NSFetchRequest<Joke>(entityName: "Joke")
        let predicate = NSPredicate(format: "time == %@", "\(time)")
        fetchRequest.predicate = predicate
        
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            return result
        } catch let error {
            debugPrint(error.localizedDescription)
        }
        return nil
    }
}
