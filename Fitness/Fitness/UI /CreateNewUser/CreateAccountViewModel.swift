//
//  CreateAccountViewModel.swift
//  Fitness
//
//  Created by Briana Bayne on 7/6/23.
//  

import Foundation
import FirebaseAuth

protocol CreateAccountViewModelDelegate: CreateAccountViewController {
    func encountered(_ error: Error)
}

struct CreateAccountViewModel {
    
    // MARK: - Properties
    private let service: FirebasServiceable
    weak var delegate: CreateAccountViewModelDelegate?
    
    // MARK: - Dependency Injection
    init(service: FirebasServiceable = FirebaseAuthService(), delegate: CreateAccountViewModelDelegate) {
        self.service = service
        self.delegate = delegate
    }
    
    // MARK: - Functions
    
    func createAccount(with email: String, password: String, confirmPassword: String) {
        if password == confirmPassword {
            service.createAccount(with: email, password: password, confirmPassword: confirmPassword) { result in
                switch result {
                case .success(_):
                    print("User was created successfully")
                case .failure(let failure):
                    delegate?.encountered(failure)
                }
            }
        } else {
            delegate?.encountered(CreateAccountError.passwordMismatch)
        }
        
    }
    func signIn(with email: String, password: String, confirmPassword: String ) {
        
        if password == confirmPassword {
            service.signIn(email: email, password: password, confirmPassword: confirmPassword) { result in
                switch result {
                case .success(_):
                    print("User was created successfully")
                    
                case .failure(let failure):
                    delegate?.encountered(failure)
                    
                }
            }
            
        }
        delegate?.encountered(CreateAccountError.passwordMismatch)
    }
}
