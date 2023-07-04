//
//  FitnessListTableViewController.swift
//  Fitness
//
//  Created by Briana Bayne on 7/4/23.
//

import UIKit

class FitnessListTableViewController: UITableViewController {

    
    // MARK: - Properties
    
    var viewModel: FitnessListViewModel!
    
// MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = FitnessListViewModel(injectedDelegate: FitnessListViewModelDelegate)
//        viewModel.fetchAllAthletes()
//        viewModel.delegate = self // Hiring the delegate to do the job duties we need.
//
    }

    // MARK: - Table view data source

 

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.fitnessSourceOfTruth?.count ?? 0 // We are returning the number of sections by the information we have from the viewModel. propery of SOT. and that will be the count. Nil coal
    }
 
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fitnessCell", for: indexPath)
        let fitness = viewModel.fitnessSourceOfTruth?[indexPath.row]
        cell.configure(with: fitness)

        return cell
    }

 
} // end of ViewController

// Posting the job on LinkdIN
 extension FitnessListTableViewController: FitnessListViewModelDelegate {
    //This is the job description on the LinkdIn Post that prob is asking for too much experince and not enough pay
    func successfullyLoadedData() {
        DispatchQueue.main.async { // ON THE MAIN THREAD
            self.tableView.reloadData()
        }
    }
}
