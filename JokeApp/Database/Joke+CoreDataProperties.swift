//
//  Joke+CoreDataProperties.swift
//  JokeApp
//
//  Created by Nitin Jain on 23/09/23.
//
//

import Foundation
import CoreData


extension Joke {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Joke> {
        return NSFetchRequest<Joke>(entityName: "Joke")
    }

    @NSManaged public var joke: String
    @NSManaged public var time: Double

    func convertToJokeModel() -> JokeModel {
        JokeModel(joke: self.joke, time: self.time)
    }
}

extension Joke : Identifiable {

}
