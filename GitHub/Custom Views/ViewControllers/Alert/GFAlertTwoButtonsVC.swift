//
//  GFAlertTwoButtonsVCViewController.swift
//  GitHub
//
//  Created by joao camargo on 07/09/21.
//

import UIKit

class GFAlertTwoButtonsVC: GFAlertVC {
    
    
    override func configureStackView(){
        containerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        //stackView.backgroundColor = .black
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.addArrangedSubview(actionButton)
        stackView.addArrangedSubview(secondaryButton)
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
        ])
    }
    
    override func configureButton(){
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        secondaryButton.addTarget(self, action: #selector(secondaryButtonAction), for: .touchUpInside)
    }
    
    
}
