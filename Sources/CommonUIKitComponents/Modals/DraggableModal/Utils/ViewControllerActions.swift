//
//  ViewControllerActions.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import UIKit

// MARK: - Life Cicle Actions
public typealias ViewControllerActions = (
    viewDidLoad: Observable<Void>,
    viewWillAppear: Observable<Void>,
    viewDidAppear: Observable<Void>,
    viewDeallocated: Observable<Void>,
    viewDismissed: Observable<Void>)
