//
//  ModalViewController.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 31/10/23.
//

import UIKit

open class DraggableModalWithCollectionViewController: UIViewController {
    public var didScroll: MutableObservable<Void> { didScrollMutableObservable }
    public var didEndDragging: MutableObservable<Void> { didEndDraggingMutableObservable }
    public var willBeginDecelerating: MutableObservable<Void> { willBeginDeceleratingMutableObservable }

    private let didScrollMutableObservable: MutableObservable<Void> = MutableObservable<Void>()
    private let didEndDraggingMutableObservable: MutableObservable<Void> = MutableObservable<Void>()
    private let willBeginDeceleratingMutableObservable: MutableObservable<Void> = MutableObservable<Void>()
}

extension DraggableModalWithCollectionViewController: UIScrollViewDelegate  {
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
