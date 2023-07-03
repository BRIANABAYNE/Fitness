//
//  Fitness.swift
//  Fitness
//
//  Created by Briana Bayne on 7/3/23.
//

import Foundation

struct Fitness {
    
     let name: String
     let coachName: String
     let nutrition: String
     let movement: String
     let PR: Double
     let score: Double
     let goal: Int
     let uuid: String = UUID().uuidString
     let colllectionType: String = "Fitness"

    
    var fitnessDictionaryRepresentation: [String: AnyHashable] {
        
        ["name": self.name,
         "coachName": self.coachName,
         "nutrition": self.nutrition,
         "movement": self.movement,
         "PR": self.PR,
         "score": self.score,
         "goal": self.goal,
         "collectionType": self.colllectionType,
         "uuid": self.uuid]
        
    }
}
