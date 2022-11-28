//
//  UICollectionViewExtensions.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import UIKit

public extension UICollectionView {
    
    func reuse<T: UICollectionViewCell>(at index: IndexPath) -> T {
        let identifier = String(describing: T.self)
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: index) as? T else {
            return T()
        }
        return cell
    }
    
}

extension UICollectionView: DynamicCollection {
    
    public func calculateSizeFor<T: UICollectionViewCell>(cellType: T.Type,
                                                          minSize: CGSize,
                                                          maxSize: CGSize? = nil,
                                                          orientation: UICollectionView.ScrollDirection,
                                                          bundle: Bundle? = nil,
                                                          cellSetup: ((T)->Void)?) -> CGSize {
        let bundle = bundle ?? bundleForXib(type: cellType)
        return calculateSizeFor(cellType: cellType,
                                with: minSize,
                                maxSize: maxSize,
                                orientation: orientation,
                                at: bundle,
                                mainSize: frame.size,
                                content: cellSetup)
    }
    
    public func calculateSizeForCellWithoutNib<T: UICollectionViewCell>(of type: T.Type,
                                                                        minSize: CGSize,
                                                                        maxSize: CGSize? = nil,
                                                                        layoutPriorities: (horizontal: UILayoutPriority, vertical: UILayoutPriority)? = nil,
                                                                        orientation: UICollectionView.ScrollDirection = .vertical,
                                                                        cellSetup: ((T)->Void)?) -> CGSize {
        calculateSizeForCellWithoutNib(of: type,
                                       mainSize: minSize,
                                       minSize: minSize,
                                       maxSize: maxSize,
                                       layoutPriorities: layoutPriorities,
                                       orientation: orientation,
                                       cellSetup: cellSetup)
    }
}

