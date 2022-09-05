//
//  BeverageCell.swift
//  BeveragesApp
//
//  Created by Yulia Popova on 3/9/2022.
//

import UIKit
import SnapKit

final class BeverageCell: UICollectionViewCell {

    static let reuseIdentifier = "BeverageCell"

    private struct UIConstants {
        static let preferedWidth = 120.0
        static let height = 23.0
    }

    private struct Styles {
        static let font = UIFont.systemFont(ofSize: 15, weight: .bold)
        static let fontColor = UIColor.white
        static let cornerRadius = 8.0
    }

    private lazy var coctailNameTitle: UILabel = {
        let title = UILabel()
        title.font = Styles.font
        title.textColor = Styles.fontColor
        title.backgroundColor = #colorLiteral(red: 0.8110429645, green: 0.8110429049, blue: 0.8110428452, alpha: 1)
        title.numberOfLines = 1
        title.layer.cornerRadius = Styles.cornerRadius
        title.layer.masksToBounds = true
        return title
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)

        coctailNameTitle.snp.makeConstraints { make in
            make.height.equalTo(UIConstants.height)
        }

        coctailNameTitle.preferredMaxLayoutWidth = UIConstants.preferedWidth

        contentView.addSubview(coctailNameTitle)
        coctailNameTitle.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.topAnchor.constraint(equalTo: coctailNameTitle.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: coctailNameTitle.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: coctailNameTitle.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: coctailNameTitle.bottomAnchor).isActive = true

    }

    public func configure(with beverage: String) {
        coctailNameTitle.text = "  " + beverage + "  "
//        widthAnchor.constraint(equalToConstant: coctailNameTitle.frame.width).isActive = true
    }
}

