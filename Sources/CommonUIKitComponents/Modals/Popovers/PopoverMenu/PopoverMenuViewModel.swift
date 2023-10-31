//
//  PopoverMenuViewModel.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 28/12/22.
//

import Foundation

protocol PopoverMenuViewModelProtocol: AnyObject {
    var items: [PopoverMenuItem] { get set }
    var numberOfItems: Int { get }
    var callBack: GenericCompletionHandler<Int> { get }
}

class PopoverMenuViewModel: PopoverMenuViewModelProtocol {

    // MARK: - Internal Properties

    var items: [PopoverMenuItem] = []
    var callBack: GenericCompletionHandler<Int>
    
    var numberOfItems: Int { items.count }

    // MARK: - Initializers

    init(callBack: @escaping GenericCompletionHandler<Int>) {
        self.callBack = callBack
    }

}
