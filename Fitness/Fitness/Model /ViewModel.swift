//
//  ViewModel.swift
//  Fitness
//
//  Created by Briana Bayne on 7/3/23.
//


import FirebaseFirestore
import Foundation

struct FitnessDetailViewModel {
    
    // cred functions (creating and save) 
    
    
    func create(name: String, coachName: String, nutrition: String, movement: String, PR: Double, score: Double, goal: Int) {
        
        let fitness = Fitness(name: name, coachName: coachName, nutrition: nutrition, movement: movement, PR: PR, score: score, goal: goal)
        
        save(parmFitness: fitness)
    }
    
    func save(parmFitness: Fitness) {
        let ref = Firestore.firestore()
        ref.collection(parmFitness.colllectionType).document(parmFitness.uuid).setData(parmFitness.fitnessDictionaryRepresentation) { error in
            if let error {
                print("AHHHHHH SOMETHINGS WRONG", error.localizedDescription)
                return
            }
        }
        
        
        
    }
    



    
} // end of
