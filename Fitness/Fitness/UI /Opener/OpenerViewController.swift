//
//  OpenerViewController.swift
//  Fitness
//
//  Created by Briana Bayne on 7/6/23.
//

import UIKit

class OpenerViewController: UIViewController {
    
    
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("one")
        let delayTime = DispatchTime.now() + 3.0
        DispatchQueue.main.asyncAfter(deadline: delayTime, execute: {
            let storyboard = UIStoryboard(name: "CreateUser", bundle: nil)
            let navigation = storyboard.instantiateViewController(withIdentifier: "CreateUser")
            self.window?.rootViewController = navigation
        })
        
        
    }
    
}
