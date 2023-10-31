//
//  ModalDataSourceImplementation.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 31/10/23.
//

import UIKit

/**
 The purpose of this class is to provide the ModalDataSource and observe the UIScrollViewDelegate methods. Another way is to directly use ModalDataSource, uncomment the default viewController implementation, implement RxSwift, and use DraggableModalScrollViewAdapter.
 **/
open class ModalDataSourceImplementation: NSObject, ModalDataSource {
    weak open var collectionView: UICollectionView?
    weak open var viewController: UIViewController?
    open var contentSize: Observable<CGSize> { MutableObservable<CGSize>() }

    public var didScroll: MutableObservable<Void> { didScrollMutableObservable }
    public var didEndDragging: MutableObservable<Void> { didEndDraggingMutableObservable }
    public var willBeginDecelerating: MutableObservable<Void> { willBeginDeceleratingMutableObservable }

    private let didScrollMutableObservable: MutableObservable<Void> = MutableObservable<Void>()
    private let didEndDraggingMutableObservable: MutableObservable<Void> = MutableObservable<Void>()
    private let willBeginDeceleratingMutableObservable: MutableObservable<Void> = MutableObservable<Void>()
}

extension ModalDataSourceImplementation: UIScrollViewDelegate  {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        DispatchQueue.main.async { self.didScrollMutableObservable.postValue(()) }
    }

    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        didEndDraggingMutableObservable.postValue(())
    }

    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        willBeginDeceleratingMutableObservable.postValue(())
    }
}
