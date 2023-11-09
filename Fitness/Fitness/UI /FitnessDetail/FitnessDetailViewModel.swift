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

// MARK: - Protocol
protocol FitnessDetailViewModelDelegate: AnyObject {
    func imageLoadedSuccessfully()
}

class FitnessDetailViewModel {
    
    // MARK: - Properties
    
    var fitness: Fitness?
    var image: UIImage?
    weak var delegate: FitnessDetailViewModelDelegate?
    private var fitnessService: FirebasServiceable
    
    // MARK: - Dependency Injection
    init(fitness: Fitness?, injectedDelegate: FitnessDetailViewModelDelegate, fitnessService: FirebasServiceable = FirebaseAuthService()) {
        self.fitness = fitness
        self.delegate = injectedDelegate
        self.fitnessService = fitnessService
        self.fetchImage(with: fitness?.id)
    }
    
    // MARK: - Crud Functions
    func create(name: String, nutrition: String, movement: String, PR: Double, goal: Int, completion: @escaping(Result<String,FirebaseError>) -> Void) {
        let fitness = Fitness(name: name, nutrition: nutrition, movement: movement, PR: PR, goal: goal, colllectionType: Constants.Fitness.fitnessCollectionPath)
        
        save(parmFitness: fitness) { result in
            switch result {
            case .success(let docID):
                completion(.success(docID))
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
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
    }
    
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
        
        guard let imageData = image.jpegData(compressionQuality: 0.1) else { return }
        
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
    
    func updateFitness(newName: String, newNutrition: String, newMovement: String) {
        
        guard let fitnessToUpdate = self.fitness else { return }
        let updateFitness = Fitness(id: fitnessToUpdate.id, name: newName, nutrition: newNutrition, movement: newMovement, PR: fitnessToUpdate.PR, goal: fitnessToUpdate.goal, colllectionType: Constants.Fitness.fitnessCollectionPath)
        
        update(fitness: updateFitness)
    }
    
    func update(fitness: Fitness) {
        if let documentID = fitness.id {
            let ref = Firestore.firestore() 
            let docRef = ref.collection(Constants.Fitness.fitnessCollectionPath).document(documentID) // collection, doc, collection, doc per firebase
            
            do {
                try docRef.setData(from: fitness)
                
            } catch {
                print(error)
            }
        }
    }
}
