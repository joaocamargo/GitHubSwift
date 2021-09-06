//
//  GFTextField.swift
//  GitHub
//
//  Created by joao camargo on 29/08/21.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2) // preferred tem relaçao com o tamanho do texto que o usuario escolhe no sistema operacional
        adjustsFontSizeToFitWidth = true // se o campo ficar maior ao escrever ele se ajusta
        minimumFontSize = 12 // este ajuste so acontece ate deixar o tamanho minimo de 12
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        returnKeyType = .go
        placeholder = "Enter a username"
        
    }
    
    
}
