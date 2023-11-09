//
//  FitnessDetailViewController.swift
//  Fitness
//
//  Created by Briana Bayne on 7/3/23.
//

import UIKit

class FitnessDetailViewController: UIViewController, AlertPresentable, UINavigationControllerDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var movementLabel: UITextField!
    @IBOutlet weak var personRecrodLabel: UITextField!
    @IBOutlet weak var goalLabel: UITextField!
    @IBOutlet weak var addButtonTap: UIButton!
    @IBOutlet weak var nutritionLabel: UITextField!
    @IBOutlet weak var fitnessDisplayImageView: UIImageView!
    
    // MARK: - Properties
    var viewModel: FitnessDetailViewModel!
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        configureView()
    }
    
    var fitness: Fitness?
    
    // MARK: - Methods
    private func configureView() {
        guard let fitness = viewModel?.fitness else { return }
        nameLabel.text = fitness.name
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
        
        guard let name = nameLabel.text,
              let nutrition = nutritionLabel.text,
              let movement = movementLabel.text,
              let personalRecord = personRecrodLabel.text,
              let goal = goalLabel.text,
              let image = fitnessDisplayImageView.image else { return }
        
        let PRasDouble = Double(personalRecord) ?? 0
        let goalAsInt = Int(goal) ?? 0
        
        if viewModel.fitness != nil {
            viewModel.updateAlthete(newName: name, newNutrition: nutrition, newMovement: movement)
            viewModel.saveImage(with: image, to: (viewModel.fitness?.id)!)
            
        } else {
            
            viewModel.create(name: name, nutrition: nutrition, movement: movement, PR: PRasDouble, goal: goalAsInt) { result in
                switch result {
                case .success(let docId):
                    self.viewModel.saveImage(with: image, to: docId)
                case .failure(let failure):
                    print(failure.errorDescription)
                }
            }
            navigationController?.popViewController(animated: true)
        }
        
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
    
    func encountered(_ error: Error) {
        presentAlert(message: error.localizedDescription, title: "Oh no!")
    }
}
