//
//  DynamicHeightCVViewController.swift
//  CommonUIKitComponents_Example
//
//  Created by Jorge Luis Rivera Ladino on 31/10/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import CommonUIKitComponents

let quotes = [
    "Luis says",
    "Add different length strings here for better testing",
    "Add different length strings here for better testing Add different length strings here for better testing",
    "Add different length strings here for better testing Add different length strings here for better testing",
    "Add different length strings here for better testing Add different length strings here for better testing",
    "Add different length strings here for better testing Add different length strings here for better testing",
    "Add different length strings here for better testing Add different length strings here for better testing",
    "Add different length strings here for better testing Add different length strings here for better testing"
]

class DynamicHeightCVViewController: DraggableModalWithCollectionViewController {
    private(set) var collectionView: UICollectionView

    init() {
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: UICollectionViewFlowLayout())
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: UICollectionViewFlowLayout())
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Dynamic size sample"

        collectionView.register(MultilineLabelCell.self, forCellWithReuseIdentifier: MultilineLabelCell.reuseId)

        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true

        collectionView.dataSource = self
        collectionView.delegate = self

        //let width = view.bounds.size.width // should adjust for inset
        //(collectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = CGSize(width: width, height: 72)

        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        //(collectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionInsetReference = .fromLayoutMargins
    }
}

// MARK: - UICollectionViewDataSource
extension DynamicHeightCVViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MultilineLabelCell = collectionView.reuse(at: indexPath)
        cell.configure(text: quotes[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        quotes.count
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DynamicHeightCVViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInset = (collectionViewLayout as! UICollectionViewFlowLayout).sectionInset
        let referenceHeight: CGFloat = 72 // Approximate height of your cell
        let referenceWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
            - sectionInset.left
            - sectionInset.right
            - collectionView.contentInset.left
            - collectionView.contentInset.right
        return CGSize(width: referenceWidth, height: referenceHeight)
    }
}

// https://stackoverflow.com/a/53102033

class MultilineLabelCell: UICollectionViewCell {
    static let reuseId = "MultilineLabelCell"

    private var tagImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .gray
    }

    private var textsStackView = UIStackView().then {
        $0.axis = .vertical
    }

    private var tagLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textColor = .black
    }

    private var tagDescriptionLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping

        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.borderWidth = 1.0
    }

    lazy var width: NSLayoutConstraint = {
        contentView.widthAnchor
            .constraint(equalToConstant: bounds.size.width)
            .isActive(true)
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Storyboards are quicker, easier, more seductive. Not stronger then Code.")
    }

    func configure(text: String?) {
        tagLabel.text = text
        tagDescriptionLabel.text = text
    }

    /*override func systemLayoutSizeFitting(
        _ targetSize: CGSize, withHorizontalFittingPriority
            horizontalFittingPriority: UILayoutPriority,
        verticalFittingPriority: UILayoutPriority) -> CGSize {

        width.constant = targetSize.width
        let size = contentView.systemLayoutSizeFitting(
            CGSize(width: targetSize.width, height: 72),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: verticalFittingPriority)

        print("\(#function) \(#line) \(targetSize) -> \(size)")
        return size
    }*/

    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        tagDescriptionLabel.preferredMaxLayoutWidth = layoutAttributes.size.width - contentView.layoutMargins.left - contentView.layoutMargins.left
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }

    private func setup() {
        //contentView.translatesAutoresizingMaskIntoConstraints = false

        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 1.0

        addSubViews()
    }

    private func addSubViews() {
        addSubview(tagImageView)
        addSubview(textsStackView)

        textsStackView.addArrangedSubview(tagLabel)
        textsStackView.addArrangedSubview(tagDescriptionLabel)


        addConstraints()
    }

    private func addConstraints() {
        textsStackView.anchor(top: topAnchor,
                              paddingTop: 18,
                              bottom: bottomAnchor,
                              paddingBottom: 18,
                              left: tagImageView.rightAnchor,
                              paddingLeft: 8,
                              right: rightAnchor,
                              paddingRight: 24,
                              width: UIScreen.main.bounds.width - 48
        )

        tagImageView.anchor(top: topAnchor,
                            paddingTop: 20,
                            left: leftAnchor,
                            paddingLeft: 24,
                            width: 32,
                            height: 32

        )
    }
}
