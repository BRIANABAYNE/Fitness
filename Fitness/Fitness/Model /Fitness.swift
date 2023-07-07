//
//  Fitness.swift
//  Fitness
//
//  Created by Briana Bayne on 7/3/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Fitness: Codable {
    @DocumentID var id: String?
    let name: String
    let coachName: String
    let nutrition: String
    let movement: String
    let PR: Double
    let score: Double
    let goal: Int
    let colllectionType: String = "Fitness"
   // let size : Size?
    
}

struct Size: Codable {
    
    var small: String
    var medium: String
    var large: String
    
    
    
}
