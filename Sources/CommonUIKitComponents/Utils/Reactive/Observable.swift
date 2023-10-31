//
//  Observable.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import Foundation

public class Observable<T> {

    public typealias Listener = (T) -> Void

    // MARK: - Internal Propertiers

    var observe: Listener = { _ in }

    // MARK: - Private Propertiers

    private(set) var property: T? {
        didSet {
            if let property = property {
                thread.async {
                    self.observe(property)
                }
            }
        }
    }

    private let thread : DispatchQueue

    // MARK: - Initializers

    public init(_ value: T? = nil,
                thread dispatcherThread: DispatchQueue = .main) {
        self.thread = dispatcherThread
        self.property = value
    }

    // MARK: - Internal Methods

    public func observe(_ listener: @escaping Listener) {
        observe = listener
    }

    // MARK: - Fileprivaye Methods

    fileprivate func postValue(_ value: T?) {
        property = value
    }

}

public class MutableObservable<T>: Observable<T> {

    // MARK: - Internal Override Methods

    override public func postValue(_ value: T?) {
        super.postValue(value)
    }

}
