//
//  FirebaseStroageService.swift
//  Fitness
//
//  Created by Briana Bayne on 11/9/23.
//

import Foundation
import UIKit
import FirebaseStorage

// MARK: - Protocol
protocol FirebaseStorageServiceable {
    func saveImage(with docID: String, from imageData: Data, completion: @escaping(Result <Bool, FirebaseError>) -> Void)
    func fetchImage(with docID: String, completion: @escaping(Result<UIImage, FirebaseError>) -> Void)
}

struct FirebaseStorageService: FirebaseStorageServiceable {
    
    let storageRef = Storage.storage().reference().child(Constants.Images.imagePath)
    
    func saveImage(with docID: String, from imageData: Data, completion: @escaping(Result <Bool, FirebaseError>) -> Void) {
        let uploadMetadata = StorageMetadata()
        uploadMetadata.contentType = "image/jpeg"
        
        storageRef.child(docID).putData(imageData, metadata: uploadMetadata) {  result in
            switch result {
            case.success(_):
                completion(.success(true))
            case.failure(let failure):
                completion(.failure(.firebaseError(failure)))
            }
        }
    }
    
    func fetchImage(with docID: String, completion: @escaping(Result<UIImage, FirebaseError>) -> Void) {
        storageRef.child(docID).getData(maxSize: 1024 * 1024) { result in
            switch result {
            case.success(let imageData):
                guard let image = UIImage(data: imageData) else { return }
                completion(.success(image))
            case.failure(let failure):
                completion(.failure(.firebaseError(failure)))
            }
        }
    }
}
