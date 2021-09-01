//
//  FollowerListVCViewController.swift
//  GitHub
//
//  Created by joao camargo on 29/08/21.
//

import UIKit

class FollowerListVC: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true 
    }

    
}
