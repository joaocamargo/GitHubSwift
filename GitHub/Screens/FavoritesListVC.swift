//
//  FavoriteListVC.swift
//  GitHub
//
//  Created by joao camargo on 28/08/21.
//

import UIKit

class FavoriteListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        PersistenceManager.retrieveFavorites { result in
            switch result {
                case .success(let favorites):
                    print(favorites)
                case .failure(let error):
                    break
            }
        }
    }


}
