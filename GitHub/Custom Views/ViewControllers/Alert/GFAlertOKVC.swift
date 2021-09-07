//
//  GFAlertVC.swift
//  GitHub
//
//  Created by joao camargo on 30/08/21.
//

import UIKit



class GFAlertOKVC: GFAlertVC {
       
    override func configureStackView(){
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)

        ])
    }
    
    override func configureButton(){
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
    }
    

}

//
//extension GFAlertVC: GFAlertVCDelegate {
//    func letGo() {
//        dismiss(animated: true)
//    }
//}

