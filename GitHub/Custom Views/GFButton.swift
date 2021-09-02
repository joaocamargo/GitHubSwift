//
//  GFButton.swift
//  GitHub
//
//  Created by joao camargo on 29/08/21.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        //custom code
        configure()
    }
    
    
    //utilizado apenas com storyboard
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, title: String){
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius    = 10        
        setTitleColor(.white, for: .normal) // WRONG WAY titleLabel?.textColor = .white
        titleLabel?.font      = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false // use autolayout!
    }
    
    
    
    
}
