//
//  UITableView+Et.swift
//  GitHub
//
//  Created by joao camargo on 12/09/21.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread(){ DispatchQueue.main.async { self.reloadData() }  }
    
    func removeExcessCells(){
        tableFooterView = UIView(frame: .zero)
    }
}
