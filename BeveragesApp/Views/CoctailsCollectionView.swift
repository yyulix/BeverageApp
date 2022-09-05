//
//  CoctailsCollectionView.swift
//  BeveragesApp
//
//  Created by Yulia Popova on 3/9/2022.
//

import UIKit

final class CoctailsCollectionView: UICollectionView {

    init() {
        let layout = LeftAlignedCollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        self.setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.showsVerticalScrollIndicator = false
    }
}

final class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {

    required override init() {
        super.init()
        common()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        common()
    }

    private func common() {
        estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        minimumLineSpacing = 10
        minimumInteritemSpacing = 10
    }

    override func layoutAttributesForElements(
        in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

            let attributes = super.layoutAttributesForElements(in: rect)

            var leftMargin: CGFloat = sectionInset.left
            var maxY: CGFloat = -1.0
            attributes?.forEach { layoutAttribute in
                if layoutAttribute.frame.origin.y >= maxY {
                    leftMargin = sectionInset.left
                }

                layoutAttribute.frame.origin.x = leftMargin
                leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
                maxY = max(layoutAttribute.frame.maxY, maxY)
            }
            return attributes
        }
}
