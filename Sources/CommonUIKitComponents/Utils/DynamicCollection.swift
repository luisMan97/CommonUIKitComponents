//
//  DynamicCollection.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import UIKit

public protocol DynamicCollection: AnyObject {
    func calculateSizeForCellWithoutNib<T: UICollectionViewCell>(
        of type: T.Type,
        mainSize: CGSize,
        minSize: CGSize,
        maxSize: CGSize?,
        layoutPriorities: (horizontal: UILayoutPriority, vertical: UILayoutPriority)?,
        orientation: UICollectionView.ScrollDirection,
        cellSetup: GenericCompletionHandler<T>?) -> CGSize
    
    func calculateSizeFor<T: UICollectionViewCell>(
        cellType: T.Type,
        minSize: CGSize,
        maxSize: CGSize?,
        orientation: UICollectionView.ScrollDirection,
        bundle: Bundle?,
        cellSetup: GenericCompletionHandler<T>?) -> CGSize
    
    func calculateSizeFor<T: UICollectionViewCell>(
        cellType: T.Type,
        with minSize: CGSize,
        maxSize: CGSize?,
        orientation: UICollectionView.ScrollDirection,
        at bundle: Bundle,
        mainSize: CGSize,
        content: GenericCompletionHandler<T>?) -> CGSize
}

extension DynamicCollection {
    
    public func calculateSizeFor<T: UICollectionViewCell>(cellType: T.Type,
                                                          with minSize: CGSize,
                                                          maxSize: CGSize? = nil,
                                                          orientation: UICollectionView.ScrollDirection,
                                                          at bundle: Bundle,
                                                          mainSize: CGSize,
                                                          content: GenericCompletionHandler<T>?) -> CGSize {
        guard let cell = UINib(nibName: String(describing: cellType),
                               bundle: bundle).instantiate(withOwner: self,
                                                           options: nil).first as? T else {
            return minSize
        }
        return calculateSizeFor(cell: cell,
                                mainSize: mainSize,
                                minSize: minSize,
                                maxSize: maxSize,
                                orientation: orientation,
                                cellSetup: content)
    }
    
    public func calculateSizeForCellWithoutNib<T: UICollectionViewCell>(of type: T.Type,
                                                                        mainSize: CGSize,
                                                                        minSize: CGSize,
                                                                        maxSize: CGSize?,
                                                                        layoutPriorities: (horizontal: UILayoutPriority, vertical: UILayoutPriority)?,
                                                                        orientation: UICollectionView.ScrollDirection,
                                                                        cellSetup: GenericCompletionHandler<T>?) -> CGSize {
        return calculateSizeFor(cell: T(),
                                mainSize: mainSize,
                                minSize: minSize,
                                maxSize: maxSize,
                                layoutPriorities: layoutPriorities,
                                orientation: orientation,
                                cellSetup: cellSetup)
        }
    
    // MARK: - Private methods
    private func calculateSizeFor<T: UICollectionViewCell>(cell: T,
                                                           mainSize: CGSize,
                                                           minSize: CGSize,
                                                           maxSize: CGSize?,
                                                           layoutPriorities: (horizontal: UILayoutPriority, vertical: UILayoutPriority)? = nil,
                                                           orientation: UICollectionView.ScrollDirection,
                                                           cellSetup: GenericCompletionHandler<T>?) -> CGSize {
        
        let mainWidth: CGFloat
        let mainHeight: CGFloat
        
        switch orientation {
        case .vertical:
            mainWidth = mainSize.width
            mainHeight = cell.frame.height
        default:
            mainWidth = cell.frame.width
            mainHeight = mainSize.height
        }
        
        cell.updateConstraintsIfNeeded()
        cell.bounds = CGRect(x: 0,
                             y: 0,
                             width: mainWidth,
                             height: mainHeight)
        
        cellSetup?(cell)
        
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        
        let containedSize: CGSize
        switch layoutPriorities {
        case .some(let priorities):
            containedSize = cell.contentView.systemLayoutSizeFitting(minSize,
                                                                     withHorizontalFittingPriority: priorities.horizontal,
                                                                     verticalFittingPriority: priorities.vertical)
        case .none:
            containedSize = cell.contentView.systemLayoutSizeFitting(minSize)
        }
        
        let height = max(containedSize.height,
                         minSize.height)
        let width = max(containedSize.width,
                        minSize.width)
        let cellSize = CGSize(width: width,
                              height: height)
        
        guard let maxSize = maxSize else { return cellSize }
        return calculate(maxSize: maxSize,
                         with: cellSize)
    }

    private func calculate(maxSize: CGSize,
                           with currentSize: CGSize) -> CGSize {
        if maxSize.width <= 0, maxSize.height <= 0 { return currentSize }
        var newSize = currentSize
        if maxSize.width > 0, newSize.width > maxSize.width {
            newSize.width = maxSize.width
            newSize.height = newSize.height * newSize.width / maxSize.width
            if maxSize.height > 0, newSize.height > maxSize.height { newSize.height = maxSize.height }
        } else if maxSize.height > 0, newSize.height > maxSize.height {
            newSize.height = maxSize.height
            newSize.width = newSize.width * newSize.height / maxSize.height
            if maxSize.width > 0, newSize.width > maxSize.width { newSize.width = maxSize.width }
        }
        return newSize
    }

}

