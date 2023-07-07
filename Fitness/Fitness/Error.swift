//
//  Error.swift
//  Fitness
//
//  Created by Briana Bayne on 7/6/23.
//
//
//import Foundation
//protocol AlertPresentable {
//    func presentAlert(message: String, title: String, withOptions actions: [UIAlertAction])
//}
//
//extension AlertPresentable where Self: UIViewController {
//    func presentAlert(message: String = "",
//                      title: String = "",
//                      withOptions actions: [UIAlertAction] = []) {
//
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        if actions.isEmpty{
//            let defaultOkayAction = UIAlertAction(title: "OK",
//                                                  style: .default)
//            alertController.addAction(defaultOkayAction)
//        } else {
//            actions.forEach { (action) in
//                alertController.addAction(action)
//            }
//        }
//        self.present(alertController, animated: true, completion: nil)
//    }
//}
