//
//  FitnessListTableViewCell.swift
//  Fitness
//
//  Created by Briana Bayne on 7/4/23.
//

import UIKit

class FitnessListTableViewCell: UITableViewCell {

  // MARK: - Outlets
    @IBOutlet weak var fitnessNameLabel: UILabel!
    @IBOutlet weak var fitnessNutritionLabel: UILabel!
    @IBOutlet weak var coachNameLabel: UILabel!
    
    
    // MARK: -  Methods
    func configure(with fitness: Fitness?) {
        guard let fitness = fitness else {return}
        fitnessNameLabel.text = fitness.name
        //fitnessSizeLabel.text = "\(fitness.size)" // making it a string becasue it is an double and we need a string with string interp
        fitnessNutritionLabel.text = fitness.nutrition
        coachNameLabel.text = fitness.coachName
        
    }

} // end of class 
