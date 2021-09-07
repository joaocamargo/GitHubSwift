//
//  UIViewController+Et.swift
//  GitHub
//
//  Created by joao camargo on 30/08/21.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!


extension UIViewController: GFAlertVCDelegate {
    func pressOKButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) { //}, completion: @escaping((Bool) -> ()) = { _ in }) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
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
    
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {   containerView.alpha = 0.8  }
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)]
        )
        
        activityIndicator.startAnimating()
    }
    
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
 
    }
    
    func showEmptyStateView(with message: String, in view: UIView) {
         let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
}
