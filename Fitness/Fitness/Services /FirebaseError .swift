//
//  FirebaseError .swift
//  Fitness
//
//  Created by Briana Bayne on 7/5/23.
//

import Foundation
enum FirebaseError: LocalizedError {
    case firebaseError(Error)
    case failedToUnwrapData
    case noDataFound
    case invalidURL
    case badImage

    var errorDescription: String? {
        switch self {
        case .firebaseError(let error):
            return "Idk man. Make this up later \(error.localizedDescription)"
        case .failedToUnwrapData:
            return "Idk man. Make this up later"
        case .noDataFound:
            return "Idk man. Make this up later"
        case .invalidURL:
            return "Idk man. Make this up later"
        case .badImage:
            return "Idk man. Make this up later"
        }
    }
}
