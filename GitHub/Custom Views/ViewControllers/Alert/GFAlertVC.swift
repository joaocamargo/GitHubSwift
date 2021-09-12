//
//  GFAlert.swift
//  GitHub
//
//  Created by joao camargo on 07/09/21.
//

import UIKit

protocol GFAlertVCDelegate: class {
    func pressOKButton()
    func pressSecondaryButton()
}

class GFAlertVC: UIViewController {
    
    let containerView = GFAlertContainerView()
    let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = GFBodyLabel(textAlignment: .center)
    let stackView = UIStackView()
    let actionButton = GFButton(backgroundColor: .systemPink, title: "Ok")
    let secondaryButton = GFButton(backgroundColor: .systemGray2, title: "Cancel")

    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    var buttonSecondaryTitle: String?
    
    let padding: CGFloat = 20
    
    weak var delegate: GFAlertVCDelegate?
    
    
    init(title: String, message: String, buttonTitle: String, buttonSecondaryTitle: String = "Cancel"){
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        //self.buttonTitle = buttonTitle
        //self.buttonSecondaryTitle = buttonSecondaryTitle
        actionButton.setTitle(buttonTitle, for: .normal)
        secondaryButton.setTitle(buttonSecondaryTitle, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        configureContainerView()
        configureTitleLabel()
        configureMessageLabel()
        configureStackView()
        configureButton()
    }
    
    func configureContainerView() {
        view.addSubview(containerView)

        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    
    func configureTitleLabel(){
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something went wrong"
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
            
        ])
    }
    
    func configureStackView() { }
    
    func configureButton(){}
    
    
    func configureMessageLabel(){
        containerView.addSubview(messageLabel)
        messageLabel.text = message ?? "Unknown error"
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            //messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }
     

    
    @objc func dismissVC(){
        print("removendo alert da tela")
        dismiss(animated: true)
        delegate?.pressOKButton()
        print("voltando")
    }
    
    @objc func secondaryButtonAction() {
        print("removendo alert da tela")
        dismiss(animated: true)
        delegate?.pressSecondaryButton()
        print("voltando")
    }
    
    
}
