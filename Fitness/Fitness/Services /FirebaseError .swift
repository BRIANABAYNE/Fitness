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
            return "\(error.localizedDescription)"
        case .failedToUnwrapData:
            return "Failed to unwrap"
        case .noDataFound:
            return "No data found"
        case .invalidURL:
            return "Issues with URL"
        case .badImage:
            return "Image can't display correctly"
        }
    }
}
