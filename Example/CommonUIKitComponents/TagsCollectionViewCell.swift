//
//  TagsCollectionViewCell.swift
//  CommonUIKitComponents_Example
//
//  Created by Jorge Luis Rivera Ladino on 28/11/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class TagsCollectionViewCell: UICollectionViewCell {

    typealias Layout = ModalTagsCellLayout

    // MARK: - IBOutlets Properties

    @IBOutlet private weak var textsStackView: UIStackView!

    @IBOutlet private weak var tagImageView: UIImageView! {
        didSet {
            tagImageView.then {
                $0.contentMode = .scaleAspectFit
            }
        }
    }
    @IBOutlet private weak var textsStackViewWidthConstraint: NSLayoutConstraint! {
        didSet {
            let textsStackViewWidth = UIScreen.main.bounds.width
            - Layout.tagImageViewPaddingLeft
            - Layout.tagImageViewWidth
            - Layout.textsStackViewPaddingLeft
            - Layout.textsStackViewPaddingRight
            textsStackViewWidthConstraint.constant = textsStackViewWidth
        }
    }
    @IBOutlet private weak var tagLabel: UILabel! {
        didSet {
            tagLabel.then {
                $0.font = .systemFont(ofSize: 16)
                $0.numberOfLines = .zero
                $0.textColor = .contentA
            }
        }
    }
    @IBOutlet private weak var tagDescriptionLabel: UILabel! {
        didSet {
            tagDescriptionLabel.then {
                $0.font = .systemFont(ofSize: 16)
                $0.numberOfLines = .zero
                $0.lineBreakMode = .byWordWrapping
                $0.textColor = .contentA
            }
        }
    }
    @IBOutlet private weak var separatorView: UIView! {
        didSet {
            separatorView.then {
                $0.backgroundColor = .borderTransparent
            }
        }
    }

    // MARK: - Internal Properties

    var productTag: Tag? {
        didSet {
            setupProductTag()
        }
    }

    // MARK: - Private Methods

    private func setupProductTag() {
        tagLabel.text = productTag?.text
        tagDescriptionLabel.text = productTag?.descriptionTag
        setTagImage(with: productTag?.iconUrl)
    }

    private func setTagImage(with urlString: String?) {
        guard let urlString = urlString else {
               return
        }

        //tagImageView.find(named: urlString)
    }

}
