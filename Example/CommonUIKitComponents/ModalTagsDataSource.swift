//
//  ModalTagsDataSource.swift
//  CommonUIKitComponents_Example
//
//  Created by Jorge Luis Rivera Ladino on 27/11/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import CommonUIKitComponents

class ModalTagsDataSource: ModalDataSourceImplementation {

    // MARK: - Internal Properties

    override var contentSize: Observable<CGSize> { contentSizeMutableObservable }

    weak override var collectionView: UICollectionView? {
        didSet {
            setupCollectionView()
        }
    }

    private(set) var data: [Tag] = []

    // MARK: - Private Properties

    private let contentSizeMutableObservable = MutableObservable<CGSize>()

    // MARK: - Initilizers

    init(data: [Tag]) {
        self.data = data
    }

    // MARK: - Private Methods

    private func setupCollectionView() {
        let nib = UINib(nibName: "TagsCollectionViewCell", bundle: Bundle(for: TagsCollectionViewCell.self))
        collectionView?.register(nib, forCellWithReuseIdentifier: "TagsCollectionViewCell")
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.isScrollEnabled = true
        collectionView?.contentInset = UIEdgeInsets(top: 20,
                                                    left: 24,
                                                    bottom: .zero,
                                                    right: 24)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1,
                                      execute: {
            guard let size = self.collectionView?.contentSize else { return }
            self.contentSizeMutableObservable.postValue(size)
        })
    }
}

extension ModalTagsDataSource: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        getModalTagsCollectionViewCell(at: indexPath,
                                       collectionView: collectionView)
    }

}

extension ModalTagsDataSource: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        getModalTagsCollectionViewCellSize(productTag: data[indexPath.row],
                                           collectionView: collectionView)
    }

}

// MARK: - This methods are called from Override Methods
private extension ModalTagsDataSource {

    func getModalTagsCollectionViewCell(at indexPath: IndexPath,
                                        collectionView: UICollectionView) -> UICollectionViewCell {
        let cell: TagsCollectionViewCell = collectionView.reuse(at: indexPath)
        cell.productTag = data[indexPath.row]
        return cell
    }

    func getModalTagsCollectionViewCellSize(productTag: Tag?,
                                            collectionView: UICollectionView) -> CGSize {
        let width = UIScreen.main.bounds.width
        let minSize = CGSize(width: width, height: 72)
        let cellSize = collectionView.calculateSizeFor(cellType: TagsCollectionViewCell.self,
                                                       minSize: minSize,
                                                       orientation: .vertical,
                                                       cellSetup: {
            $0.productTag = productTag
        })
        return cellSize
    }
}
