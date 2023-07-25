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
    let nutrition: String
    let movement: String
    let PR: Double
    let goal: Int
    let colllectionType: String 
}


