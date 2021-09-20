//
//  UIView+Ext.swift
//  GitHub
//
//  Created by joao camargo on 12/09/21.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...){
        for view in views {  addSubview(view) }
    }
    
    
    func addSubviews(_ views: [UIView]) {
        views.forEach(self.addSubview)
    }
    
    
    func pinToEdges(of superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
}
