//
//  TitleContainerView.swift
//  BeveragesApp
//
//  Created by Yulia Popova on 3/9/2022.
//

import UIKit
import SnapKit

final class TitleContainerView: UIView {

    private struct UIConstants {
        static let horizontalPadding: CGFloat = 16.0
    }

    private struct Styles {
        static let backgroundColor = UIColor.AppColors.backgroundColor
        static let titleFont = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = Styles.titleFont
        return label
    }()

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(UIConstants.horizontalPadding)
            make.centerY.equalToSuperview()
        }
        backgroundColor = Styles.backgroundColor
    }

    public func configure(with title: String) {
        titleLabel.text = title
    }
}
