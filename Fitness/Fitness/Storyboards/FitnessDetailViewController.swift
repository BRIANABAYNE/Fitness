//
//  FitnessDetailViewController.swift
//  Fitness
//
//  Created by Briana Bayne on 7/3/23.
//

import UIKit

class FitnessDetailViewController: UIViewController {

   
    // MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var coachNameLabel: UITextField!
    @IBOutlet weak var movementLabel: UITextField!
    @IBOutlet weak var personRecrodLabel: UITextField!
    @IBOutlet weak var goalLabel: UITextField!
    @IBOutlet weak var scoreLabel: UITextField!
    @IBOutlet weak var addButtonTap: UIButton!
    @IBOutlet weak var nutritionLabel: UITextField!
    

    // MARK: - Property
    var viewModel: FitnessDetailViewModel!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        viewModel = FitnessDetailViewModel()
            }
    
// MARK: - Actions

    @IBAction func addButtonTapped(_ sender: Any) {
        
        guard let name = nameLabel.text,
              let nutrition = nutritionLabel.text,
              let coachName = coachNameLabel.text,
              let movement = movementLabel.text,
              let personalRecord = personRecrodLabel.text,
              let goal = goalLabel.text,
              let score = scoreLabel.text else { return }
                
        let PRasDouble = Double(personalRecord) ?? 0
        let scoreAsDouble = Double(score) ?? 0
        let goalAsInt = Int(goal) ?? 0
        
        viewModel.create(name: name, coachName: coachName, nutrition: nutrition, movement: movement, PR: PRasDouble, score: scoreAsDouble, goal: goalAsInt)
        
    }
    
}
