//
//  PopoverMenuTableViewCell.swift
//  CommonUIKitComponents
//
//  Created by Jorge Luis Rivera Ladino on 28/12/22.
//

import UIKit

public class PopoverMenuTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets Properties

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var bottomView: UIView!
    
    // MARK: - Internal Properties
    
    var popoverMenuItem: PopoverMenuItem? {
        didSet { setupView() }
    }
    
    var bottomViewHidde = false {
        didSet { bottomView.isHidden = bottomViewHidde }
    }
    
    // MARK: - Override Methods
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        guard let popoverMenuItem = popoverMenuItem else {
            return
        }
        iconImageView.image = UIImage(named: popoverMenuItem.icon)
        titleLabel.text = popoverMenuItem.title
    }
    
}
