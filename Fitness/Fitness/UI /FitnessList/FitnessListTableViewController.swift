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


    }

    // MARK: - Table view data source

    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchAllAthletes()
    }
    
    // This is not currently connected to anything that can send an action
    // Next steps would be to place a button, then link this action to that button
    @IBAction func logOutButtonTapped(_ sender: Any) {
        FirebaseAuthService().signOut()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.fitnessSourceOfTruth.count
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
     
        guard let destination = segue.destination as? FitnessDetailViewController else { return }
        if segue.identifier == "toDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let fitnessApp = viewModel.fitnessSourceOfTruth[indexPath.row]
            destination.viewModel = FitnessDetailViewModel(fitness: fitnessApp, injectedDelegate: destination)
        } else {
            destination.viewModel = FitnessDetailViewModel(fitness: nil, injectedDelegate: destination)
        }
    }
}

 extension FitnessListTableViewController: FitnessListViewModelDelegate {
    func successfullyLoadedData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
