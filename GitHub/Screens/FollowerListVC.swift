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
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { (followers, errorMessage) in
            guard let followers = followers else {
                self.presentGFAlertOnMainThread(title: "Error", message: errorMessage!.rawValue, buttonTitle: "Ok")
                return
            }
            
            print("Followers.count \(followers.count)\n")
            print(followers)
            
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigationController?.isNavigationBarHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)

    }

    
}
