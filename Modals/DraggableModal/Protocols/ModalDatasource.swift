//
//  ModalDatasource.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import UIKit

// ModalDataSource  is used to inject the collection view to the datasource as well as the view controller to the ListAdapter of IGListKit
// It also allows us to obtain a reactive content size for a future update of the layout.
public protocol ModalDataSource: UIScrollViewDelegate {
    var collectionView: UICollectionView? { get set }
    /// This property **MUST** be weak when implemented.
    var viewController: UIViewController? { get set }
    var contentSize: Observable<CGSize> { get }
}

// MARK: - ModalDataSource Default Implementation
public extension ModalDataSource {

    var viewController: UIViewController? {
        get { nil }
        set {}
    }

}
