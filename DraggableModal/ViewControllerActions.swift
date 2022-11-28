//
//  ViewControllerActions.swift
//  CommonUIKitComponents
//
//  Created by Jorge Rivera on 27/11/22.
//

import UIKit

// MARK: - Life Cicle Actions
public typealias ViewControllerActions = (
    viewDidLoad: Observable<Void>,
    viewWillAppear: Observable<Void>,
    viewDidAppear: Observable<Void>,
    viewDeallocated: Observable<Void>,
    viewDismissed: Observable<Void>)
