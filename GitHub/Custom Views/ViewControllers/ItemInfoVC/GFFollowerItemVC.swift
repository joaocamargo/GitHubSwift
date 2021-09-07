//
//  GFFollowerItemVC.swift
//  GitHub
//
//  Created by joao camargo on 07/09/21.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        
    }
       
    private func configureItems(){
        itemInfoViewOne.set(intemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(intemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "GitHub Followers")
    }
    
}
