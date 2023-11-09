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
protocol FitnessDetailViewModelDelegate: FitnessDetailViewController {
    func imageLoadedSuccessfully()
    func encountered(_ error: Error)
}

class FitnessDetailViewModel {
    
    // MARK: - Properties
    
    var fitness: Fitness?
    var image: UIImage?
    weak var delegate: FitnessDetailViewModelDelegate?
    private var fitnessService: FirebaseStorageServiceable
    private var dataBaseService: FirebaseDataBaseServiceable
    
    // MARK: - Dependency Injection
    init(fitness: Fitness?, injectedDelegate: FitnessDetailViewModelDelegate, fitnessService: FirebaseStorageServiceable = FirebaseStorageService(), dataBaseService: FirebaseDataBaseServiceable = FirebaseDataBaseService()) {
        self.fitness = fitness
        self.delegate = injectedDelegate
        self.fitnessService = fitnessService
        self.dataBaseService = dataBaseService
        self.fetchImage(with: fitness?.id)
    }
    
    // MARK: - Crud Functions
    func create(name: String, nutrition: String, movement: String, PR: Double, goal: Int, completion: @escaping(Result<String,FirebaseError>) -> Void) {
        let fitness = Fitness(name: name, nutrition: nutrition, movement: movement, PR: PR, goal: goal, colllectionType: Constants.Fitness.fitnessCollectionPath)
        dataBaseService.createAthelete(fitness: fitness, completion: { [weak self] result in
            switch result {
            case .success(let docID):
                completion(.success(docID))
            case .failure(let failure):
                self?.delegate?.encountered(failure)
            }
        })
        
    }
    
    func fetchImage(with id: String?) {
        guard let id else { return }
        fitnessService.fetchImage(with: id) { [weak self] result in
            switch result {
            case .success(let image):
                self?.image = image
                self?.delegate?.imageLoadedSuccessfully()
            case .failure(let failure):
                self?.delegate?.encountered(failure)
            }
        }
    }
    
    func saveImage(with image: UIImage, to docID: String) { // child is the path per the docs
        
        guard let imageData = image.jpegData(compressionQuality: 0.1) else { return }
        fitnessService.saveImage(with: docID, from: imageData) { [weak self] result in
            switch result {
            case .success(_):
                self?.delegate?.imageLoadedSuccessfully()
            case .failure(let failure):
                self?.delegate?.encountered(failure)
            }
        }
        
    }
    
    func updateAlthete(newName: String, newNutrition: String, newMovement: String) {
        
        guard let fitnessToUpdate = self.fitness else { return }
        let updateFitness = Fitness(id: fitnessToUpdate.id, name: newName, nutrition: newNutrition, movement: newMovement, PR: fitnessToUpdate.PR, goal: fitnessToUpdate.goal, colllectionType: Constants.Fitness.fitnessCollectionPath)
        
        update(fitness: updateFitness)
    }
    
    func update(fitness: Fitness) {
        dataBaseService.updateAthletes(fitness: fitness) { [weak self] result in
            switch result {
            case .success(_):
                print("Bag updated sucessfully")
            case .failure(let failure):
                self?.delegate?.encountered(failure)
            }
        }
    }
}
