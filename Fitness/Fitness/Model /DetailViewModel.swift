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
        let sizeDict = Size(small:"Skinny and wants to gain weight with muscle mass", medium:"Wants to add more muscle", large:"Looking to loose fat but maintain muscle")
        let fitness = Fitness(name: name, coachName: coachName, nutrition: nutrition, movement: movement, PR: PR, score: score, goal: goal, size: sizeDict)
        
        save(parmFitness: fitness)
    }
    // Method singnature 
    func save(parmFitness: Fitness) {
        let ref = Firestore.firestore()
        do {
            try ref.collection(parmFitness.colllectionType).addDocument(from: parmFitness)
        } catch {
            print("Oh no, something went wrong.", error.localizedDescription)
            return 
        }
    }

    
} // end of DV 
