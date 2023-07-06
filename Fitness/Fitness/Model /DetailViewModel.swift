//
//  ViewModel.swift
//  Fitness
//
//  Created by Briana Bayne on 7/3/23.
//


import FirebaseFirestore
import Foundation
import FirebaseFirestoreSwift
import FirebaseStorage


protocol FitnessDetailViewModelDelegate: AnyObject {
    func imageLoadedSuccessfully()
}

// Had to change to class to get self.
class FitnessDetailViewModel {
    
    // MARK: - Properties
    
    var fitness: Fitness?
    var image: UIImage?
    weak var delegate: FitnessDetailViewModelDelegate?
    
    
    init(fitness: Fitness?, injectedDelegate: FitnessDetailViewModelDelegate) {
        self.fitness = fitness
        self.delegate = injectedDelegate
        self.fetchImage(with: fitness?.id)
    }
    
    
    // cred functions (creating and save)
    func create(name: String, coachName: String, nutrition: String, movement: String, PR: Double, score: Double, goal: Int, completion: @escaping(Result<String,FirebaseError>) -> Void) {
        let sizeDict = Size(small:"Skinny and wants to gain weight with muscle mass", medium:"Wants to add more muscle", large:"Looking to loose fat but maintain muscle")
        let fitness = Fitness(name: name, coachName: coachName, nutrition: nutrition, movement: movement, PR: PR, score: score, goal: goal, size: sizeDict)
        
        save(parmFitness: fitness) { result in
            switch result {
            case .success(let docID):
                completion(.success(docID))
            case .failure(let failure):
                print(failure)
            }
            
        }
    }
    // Method singnature
    func save(parmFitness: Fitness, completion: @escaping(Result<String, FirebaseError>) -> Void ) {
        let ref = Firestore.firestore()
        do {
            let documentRef = try ref.collection(Constants.Fitness.fitnessCollectionPath).addDocument(from: parmFitness, completion: { _ in
                
            })
            completion(.success(documentRef.documentID))
        } catch {
            print("Oh no, something went wrong.", error.localizedDescription)
            return
        }
    } // end of save
    
    
    func fetchImage(with id: String?) {
        guard let id else { return }
        let storageRef = Storage.storage().reference()
        
        storageRef.child(Constants.Images.imagePath).child(id).getData(maxSize: 1024 * 1024) { result in
            switch result {
            case.success(let imageData):
                guard let image = UIImage(data: imageData) else { return }
                self.image = image
                self.delegate?.imageLoadedSuccessfully()
            case.failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func saveImage(with image: UIImage, to docID: String) { // child is the path per the docs
        
        // Convert the image to data
        guard let imageData = image.jpegData(compressionQuality: 0.1) else { return }
        
        // Building
        let storageRef = Storage.storage().reference()
        
        storageRef.child(Constants.Images.imagePath).child(docID).putData(imageData) { metaData, error in
            if let error {
                print("Something happened")
                return
            }
            let imagePath = metaData?.path
            print(imagePath)
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
} // end of DV
