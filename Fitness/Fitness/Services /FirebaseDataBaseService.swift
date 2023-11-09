//
//  FirebaseDataBaseService.swift
//  Fitness
//
//  Created by Briana Bayne on 11/9/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

// MARK: - Protocol
protocol FirebaseDataBaseServiceable {
    func fetchAllAthletes(completion: @escaping (Result<[Fitness], FirebaseError>) -> Void)
    func deleteAtheleteInfo(fitness: Fitness, completion: @escaping(Result<Bool, FirebaseError>) -> Void)
    func updateAthletes(fitness: Fitness, completion: @escaping(Result<Bool, FirebaseError>) -> Void )
    func createAthelete(fitness: Fitness, completion: @escaping(Result<String, FirebaseError>) -> Void)
}

struct FirebaseDataBaseService: FirebaseDataBaseServiceable {
  
    let dataBase = Firestore.firestore().collection(Constants.Fitness.fitnessCollectionPath)
    
    
    func fetchAllAthletes(completion: @escaping (Result<[Fitness], FirebaseError>) -> Void) {
        dataBase.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            do {
                let fitnessArray = try documents.compactMap({ try $0.data(as: Fitness.self)})
                completion(.success(fitnessArray))
            } catch {
                completion(.failure(.firebaseError(error)))
            }
        }
    }
    
    func deleteAtheleteInfo(fitness: Fitness, completion: @escaping(Result<Bool, FirebaseError>) -> Void) {
        dataBase.document(fitness.id!).delete { error in
            if let error {
                completion(.failure(.firebaseError(error)))
            }
            completion(.success(true))
        }
    }
    
    func updateAthletes(fitness: Fitness, completion: @escaping(Result<Bool, FirebaseError>) -> Void ) {
        if let documentID = fitness.id {
            let documentRef = dataBase.document(documentID)
            do {
                try documentRef.setData(from: fitness)
                completion(.success(true))
            } catch {
                completion(.failure(.firebaseError(error)))
            }
        }
    }
    
    func createAthelete(fitness: Fitness, completion: @escaping(Result<String, FirebaseError>) -> Void) {
        do {
            let documentRef = try dataBase.addDocument(from: fitness, completion: { error in
                if let error {
                    completion(.failure(.firebaseError(error)))
                }
            })
            completion(.success(documentRef.documentID))
        } catch {
            completion(.failure(.firebaseError(error)))
        }
    }
}
