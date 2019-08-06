//
//  UITableView+Extensions.swift
//  Custom Views tutorial Practice RW
//
//  Created by Conovo-MacMini on 20/06/2019.
//  Copyright © 2019 Conovo-MacMini. All rights reserved.
//

import UIKit
extension UITableView {
    public func registerCell<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
        
    }
    
    public func dequeReusableCell<Cell: UITableViewCell>(forIndexPath indexPath: IndexPath) -> Cell {
        let identifier = String(describing: Cell.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? Cell else {
            fatalError("Error for cell id: \(identifier) at  \(indexPath)")
        }
        return cell
    }
}
