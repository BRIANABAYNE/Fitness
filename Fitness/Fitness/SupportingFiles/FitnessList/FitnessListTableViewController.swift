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
        viewModel = FitnessListViewModel(injectedDelegate: self)
//        viewModel.fetchAllAthletes()
//        viewModel.delegate = self // Hiring the delegate to do the job duties we need.
//
    }

    // MARK: - Table view data source

    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchAllAthletes()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.fitnessSourceOfTruth.count // We are returning the number of sections by the information we have from the viewModel. propery of SOT. and that will be the count. 
    }
 
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fitnessCell", for: indexPath) as! FitnessListTableViewCell
        let fitness = viewModel.fitnessSourceOfTruth[indexPath.row]
        cell.configure(with: fitness)

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.delete(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // IIDOO - identifer, indexpath, destination
        guard let destination = segue.destination as? FitnessDetailViewController else { return }
        if segue.identifier == "toDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let fitnessApp = viewModel.fitnessSourceOfTruth[indexPath.row]
            destination.viewModel = FitnessDetailViewModel(fitness: fitnessApp, injectedDelegate: destination)
        } else {
            destination.viewModel = FitnessDetailViewModel(fitness: nil, injectedDelegate: destination)
        }
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
