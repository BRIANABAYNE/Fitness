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
    @IBOutlet weak var fitnessPRLabel: UILabel!
    @IBOutlet weak var fitnessMovementLabel: UILabel!
    
    
    // MARK: -  Methods
    func configure(with fitness: Fitness?) {
        guard let fitness = fitness else {return}
        fitnessNameLabel.text = fitness.name
        fitnessPRLabel.text = "\(fitness.PR)"
        fitnessMovementLabel.text = fitness.movement
    }

} // end of class 
