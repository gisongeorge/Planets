//
//  Extensions.swift
//  Planets
//
//  Created by Gisonmon George on 13/05/23.
//

import UIKit

extension UITableView {
    
    // To register cell on the table view
    func registerCell(identifier: String) {
        let cellId = String(describing: identifier)
        register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: identifier)
    }
}

extension UITableViewCell {
    
    // To get the cell identifier, using the cell identifier same as the cell name
    static var identifier: String {
        return String(describing: self)
    }
}
