//
//  GFRepoItemVC.swift
//  GitHub
//
//  Created by joao camargo on 07/09/21.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        
    }
       
    private func configureItems(){
        itemInfoViewOne.set(intemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(intemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    
}
