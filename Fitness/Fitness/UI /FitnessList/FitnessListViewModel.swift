//
//  ViewModel.swift
//  Fitness
//
//  Created by Briana Bayne on 7/4/23.
//

import Foundation
import FirebaseFirestore

// MARK: - Protocol
protocol FitnessListViewModelDelegate: FitnessListTableViewController {
    func successfullyLoadedData()
}

class FitnessListViewModel {
    
    // MARK: - Properties
    var service: FirebaseDataBaseServiceable
    var fitnessSourceOfTruth: [Fitness]?
    weak var delegate: FitnessListViewModelDelegate?

    // MARK: - Dependency Injection
    init(injectedDelegate: FitnessListViewModelDelegate, service: FirebaseDataBaseServiceable = FirebaseDataBaseService()) {
        self.delegate = injectedDelegate
        self.service = service
    }
    
    func fetchAllAthletes() {
        service.fetchAllAthletes { [weak self] result in
            switch result {
            case .success(let fetchedAlthletes):
                self?.fitnessSourceOfTruth = fetchedAlthletes
                self?.delegate?.successfullyLoadedData()
            case .failure(let error):
                self?.delegate?.encountered(error)
            }
        }
    }
    
    func delete(indexPath: IndexPath, callback: @escaping () -> Void) {
        guard let fitness = fitnessSourceOfTruth?[indexPath.row] else { return }
        service.deleteAtheleteInfo(fitness: fitness) { [weak self] result in
            switch result {
            case .success(_):
                self?.fitnessSourceOfTruth?.remove(at: indexPath.row)
                callback()
            case .failure(let failure):
                self?.delegate?.encountered(failure)
            }
        }
    }
}
