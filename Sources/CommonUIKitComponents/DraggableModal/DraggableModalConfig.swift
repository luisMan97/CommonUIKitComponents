//
//  DraggableModalConfig.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//

import UIKit

// DraggableModalConfig is used to allow a series of configurations for the modal
public struct DraggableModalConfig {
    public let header: ModalHeaderComponent
    public let bottom: BottomViewComponent?
    public let dataSource: ModalDataSource
    public var backgroundImage: UIImageView?
    public var leastProportion: CGFloat = 0.95
    public var higherProportion: CGFloat = 0.95
    public var percentThreshold: CGFloat = 0.75
    public var refreshLayoutAfterUpdate: Bool = false
    public var isExpandable: Bool = true
    public var generateFeedback: Bool = true
    public var hiddenTopIndicator: Bool = false

    public init(header: ModalHeaderComponent, bottom: BottomViewComponent?, dataSource: ModalDataSource, backgroundImage: UIImageView? = nil) {
        self.header = header
        self.dataSource = dataSource
        self.bottom = bottom
        self.backgroundImage = backgroundImage
    }

    public init(header: ModalHeaderComponent, dataSource: ModalDataSource) {
        self.header = header
        self.dataSource = dataSource
        self.bottom = ModalCloseBottomComponent()
    }

    public init(dataSource: ModalDataSource) {
        let insets = UIEdgeInsets(top: .spacing(4), left: 0, bottom: .spacing(4), right: 0)
        self.header = BaseModalHeaderComponent(config: BaseModalHeaderConfig(contentInsets: insets))
        self.dataSource = dataSource
        self.bottom = ModalCloseBottomComponent()
    }
}
