//
//  GFItemInfoView.swift
//  GitHub
//
//  Created by joao camargo on 07/09/21.
//

import UIKit

enum ItemInfoType {
    case repos,gists, followers,following
}

class GFItemInfoView: UIView {

    let symboolImageView = UIImageView()
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configure() {
        addSubview(symboolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        symboolImageView.translatesAutoresizingMaskIntoConstraints = false
        symboolImageView.contentMode = .scaleAspectFill
        symboolImageView.tintColor = .label
        
        NSLayoutConstraint.activate([
            symboolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symboolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symboolImageView.widthAnchor.constraint(equalToConstant: 20),
            symboolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symboolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symboolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: symboolImageView.bottomAnchor,constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func set(intemInfoType: ItemInfoType, withCount count: Int){
        switch intemInfoType {
        case .repos:
            symboolImageView.image = UIImage(systemName: SFSymbols.repos)
            titleLabel.text = "Public Repos"
        case .gists:
            symboolImageView.image = UIImage(systemName: SFSymbols.gists)
            titleLabel.text = "Public Gists"
        case .followers:
            symboolImageView.image = UIImage(systemName: SFSymbols.followers)
            titleLabel.text = "Followers"
        case .following:
            symboolImageView.image = UIImage(systemName: SFSymbols.following)
            titleLabel.text = "Following"
        }

        countLabel.text = "\(count)"

    }

}
