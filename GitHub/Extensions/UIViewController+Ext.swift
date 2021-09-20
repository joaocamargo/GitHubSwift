//
//  UIViewController+Et.swift
//  GitHub
//
//  Created by joao camargo on 30/08/21.
//

import UIKit
import SafariServices


//classebvc

//fileprivate var containerView: UIView!

protocol AlertButtonsUIViewControllerDelegate {
    func doFirst()
    func doSecond()
}

var delegateAlertButtons: AlertButtonsUIViewControllerDelegate?


extension UIViewController: GFAlertVCDelegate {

    func pressSecondaryButton() {
        delegateAlertButtons?.doSecond()
    }
    
    func pressOKButton() {
        delegateAlertButtons?.doFirst()
    }
        
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) { //}, completion: @escaping((Bool) -> ()) = { _ in }) {
        DispatchQueue.main.async {
            let alertVC = GFAlertOKVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.delegate = self
            alertVC.modalPresentationStyle =  .overFullScreen
            alertVC.modalTransitionStyle =  .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredBarTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
    
 
    
}
