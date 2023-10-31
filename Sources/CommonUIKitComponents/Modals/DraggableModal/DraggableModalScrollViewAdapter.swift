//
//  DraggableModalScrollViewAdapter.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 28/11/22.
//

import RxSwift
import RxCocoa

class DraggableModalScrollViewAdapter {

    var scrollView: UIScrollView?
    var didScroll: MutableObservable<Void> = MutableObservable<Void>()
    var didEndDragging: MutableObservable<Void> = MutableObservable<Void>()
    var willBeginDecelerating: MutableObservable<Void> = MutableObservable<Void>()

    private let disposeBag: DisposeBag = DisposeBag()

    init(scrollView: UIScrollView?) {
        self.scrollView = scrollView
        subscribeToScroll()
    }

    func subscribeToScroll() {
        scrollView?.rx.didScroll
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] in
                self?.didScroll.postValue(())
            }).disposed(by: disposeBag)

        scrollView?.rx.didEndDragging
            .asDriver()
            .drive(onNext: { [weak self] _ in
                self?.didEndDragging.postValue(())
            }).disposed(by: disposeBag)

        scrollView?.rx.willBeginDecelerating
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.willBeginDecelerating.postValue(())
            }).disposed(by: disposeBag)
    }
    
}
