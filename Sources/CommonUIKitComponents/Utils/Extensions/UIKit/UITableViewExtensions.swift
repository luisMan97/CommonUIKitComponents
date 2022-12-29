//
//  UITableViewExtensions.swift
//  CommonUIKitComponents
//
//  Created by Jorge Rivera on 28/12/22.
//


import UIKit

public extension UITableView {
    
    func reuse<T: UITableViewCell>(at index: IndexPath) -> T {
        let identifier = String(describing: T.self)
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: index) as? T else {
            return T()
        }
        return cell
    }
    
}
