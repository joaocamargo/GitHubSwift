//
//  GFAvatarImageView.swift
//  GitHub
//
//  Created by joao camargo on 04/09/21.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    
    let placeholderImage = UIImage(named: "avatar-placeholder")!

    override init(frame: CGRect){
        super.init(frame:frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }

}
