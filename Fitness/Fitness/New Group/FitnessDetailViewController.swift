//
//  FitnessDetailViewController.swift
//  Fitness
//
//  Created by Briana Bayne on 7/3/23.
//

import UIKit

class FitnessDetailViewController: UIViewController, UINavigationControllerDelegate {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var coachNameLabel: UITextField!
    @IBOutlet weak var movementLabel: UITextField!
    @IBOutlet weak var personRecrodLabel: UITextField!
    @IBOutlet weak var goalLabel: UITextField!
    @IBOutlet weak var scoreLabel: UITextField!
    @IBOutlet weak var addButtonTap: UIButton!
    @IBOutlet weak var nutritionLabel: UITextField!
    @IBOutlet weak var fitnessDisplayImageView: UIImageView!
    
    
    // MARK: - Property
    var viewModel: FitnessDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        configureView()
        
        
    }
    
    
// MARK: - Methods
    private func configureView() {
        guard let fitness = viewModel?.fitness else { return }
        nameLabel.text = fitness.name
        coachNameLabel.text = fitness.coachName
        movementLabel.text = fitness.movement
        personRecrodLabel.text = "\(fitness.PR)" // string interp
        goalLabel.text = "\(fitness.goal)" // string interp
        nutritionLabel.text = fitness.nutrition
        
        
        viewModel.fetchImage(with:fitness.id)
        
    }
    
    private func setupImageView() {
        fitnessDisplayImageView.isUserInteractionEnabled = true
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        fitnessDisplayImageView.addGestureRecognizer(tapGuesture)
        
    }
    
    @objc func imageViewTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: Any) {
        
    // MARK: - Methods
        
        // Reading the data
        guard let name = nameLabel.text,
              let nutrition = nutritionLabel.text,
              let coachName = coachNameLabel.text,
              let movement = movementLabel.text,
              let personalRecord = personRecrodLabel.text,
              let goal = goalLabel.text,
              let score = scoreLabel.text,
              let image = fitnessDisplayImageView.image else { return }
        
        // NIL COAL
        let PRasDouble = Double(personalRecord) ?? 0
        let scoreAsDouble = Double(score) ?? 0
        let goalAsInt = Int(goal) ?? 0
        
        viewModel.create(name: name, coachName: coachName, nutrition: nutrition, movement: movement, PR: PRasDouble, score: scoreAsDouble, goal: goalAsInt) { result in
            switch result {
            case .success(let docId):
                self.viewModel.saveImage(with: image, to: docId)
            case .failure(let failure):
                print(failure.errorDescription)
            }
        }
        navigationController?.popViewController(animated: true) // POP off the viewController like a pancake stack.
    }
    
} // end of VC

extension FitnessDetailViewController: UIImagePickerControllerDelegate, UINavigationBarDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
        fitnessDisplayImageView.image = image
        picker.dismiss(animated: true)
        
        
    }
}

extension FitnessDetailViewController: FitnessDetailViewModelDelegate {
    func imageLoadedSuccessfully() {
        DispatchQueue.main.async {
            self.fitnessDisplayImageView.image = self.viewModel.image
        }
    }
}
