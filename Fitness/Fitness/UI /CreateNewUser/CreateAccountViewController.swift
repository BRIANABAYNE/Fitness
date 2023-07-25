//
//  CreateAccountViewController.swift
//  Fitness
//
//  Created by Briana Bayne on 7/6/23.
//

import UIKit

class CreateAccountViewController: UIViewController, AlertPresentable {
    
    // MARK: - outlets
    
    @IBOutlet weak var addressLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var olyPictureImageView: UIImageView!
    
    
    var viewModel: CreateAccountViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CreateAccountViewModel(delegate: self)
        
    }
    

    // MARK: - Actions
    
    @IBAction func createButtonTapped(_ sender: Any) {
        
        guard let email = addressLabel.text,
              let password = passwordLabel.text,
              let confirmPassword = confirmPassword.text else { return }
        viewModel.createAccount(with: email, password: password, confirmPassword: confirmPassword)
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        guard let email = addressLabel.text,
              let password = passwordLabel.text,
              let confirmPassword = confirmPassword.text else { return }
        viewModel.signIn(with: email, password: password)
    } // sing button tapped

    
} // end of VC

extension CreateAccountViewController: CreateAccountViewModelDelegate {
    func encountered(_ error: Error) {
        presentAlert(message: error.localizedDescription, title: "Oh no!")
    }
}
