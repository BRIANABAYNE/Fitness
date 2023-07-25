//
//  FirebaseService.swift
//  Fitness
//
//  Created by Briana Bayne on 7/6/23.
//

import Foundation
import FirebaseAuth

protocol FirebasServiceable {
    func createAccount(with email: String, password: String, handler: @escaping(Result<Bool, CreateAccountError>) -> Void)
    func signIn(with email: String, password: String, handler: @escaping(Result<Bool, CreateAccountError>) -> Void)
    func signOut()
}

struct FirebaseService: FirebasServiceable {
    
    func createAccount(with email: String, password: String, confirmPassword: String, completion: @escaping(Result<Bool, CreateAccountError>) -> Void) {
        // I only want to create a user if the passwords match
            Auth.auth().createUser(withEmail:email, password: password) { authResult, fireBaseError in
                if let fireBaseError {
                    completion(.failure(.firebaseError(fireBaseError)))
                }
                completion(.success(true))
     }
    } // created
                           
    
    func signIn(email: String, password: String, confirmPassword: String, completion: @escaping(Result<Bool, CreateAccountError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error {
                completion(.failure(.firebaseError(error)))
            }
            completion(.success(true))
        }
    } // end of sing in
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signoutError as NSError {
            print("Error signing out", signoutError)
        }
    }
} // Firebase Service 
