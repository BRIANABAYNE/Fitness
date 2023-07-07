//
//  CreateAccountViewController.swift
//  Fitness
//
//  Created by Briana Bayne on 7/6/23.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    // MARK: - outlets
    
    @IBOutlet weak var addressLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var olyPictureImageView: UIImageView!
    
    
    var viewModel: CreateAccountViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CreateAccountViewModel()
        
    }
    

    // MARK: - Actions
    
    @IBAction func createButtonTapped(_ sender: Any) {
        
        guard let email = addressLabel.text,
              let password = passwordLabel.text,
              let confirmPassword = confirmPassword.text else { return }
        viewModel.createAccount(with: email, password: password, confirmPassword: confirmPassword)
    }
    
    
    @IBAction func singInButtonTapped(_ sender: Any) {
        guard let email = addressLabel.text,
              let password = passwordLabel.text,
              let confirmPassword = confirmPassword.text else { return }
        viewModel.signIn(with: email, password: password, confirmPassword: confirmPassword)
    }

    
}
