//
//  ViewModel.swift
//  Fitness
//
//  Created by Briana Bayne on 7/4/23.
//

import Foundation
import FirebaseFirestore


// creating the job posting and that is the first step when setting a protocal and delegate
protocol FitnessListViewModelDelegate: FitnessListTableViewController {
    func successfullyLoadedData() 
}

class FitnessListViewModel {
    
    
   // MARK: - Properties
  
    
    var fitnessSourceOfTruth: [Fitness]?
    // The task that the person who is hired will do. 
    weak var delegate: FitnessListViewModelDelegate?
    
    // Dependency Injection - Makes our code easier to test
    init(injectedDelegate: FitnessListViewModelDelegate) {
        self.delegate = injectedDelegate // hiring the person
        fetchAllAthletes() // duty of the person hired
    }
    
    
    func fetchAllAthletes() {
        let db = Firestore.firestore()
        db.collection(Constants.Fitness.fitnessCollectionPath).getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {return}
            do {
                let fitnessArray = try documents.compactMap({try $0.data(as: Fitness.self)})
                self.fitnessSourceOfTruth? = fitnessArray
                print(fitnessArray)
            } catch {
                
            }
        }
    }
} // end of ListViewModel
