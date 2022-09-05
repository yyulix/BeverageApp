//
//  DetailedCardView.swift
//  BeveragesApp
//
//  Created by Yulia Popova on 3/9/2022.
//

import UIKit
import SnapKit
import Kingfisher

final class DetailedCardView: UIView {

    private struct UIConstants {
        static let titleViewHeight: CGFloat = 58.0
        static let cornerRadius: CGFloat = 8.0
    }

    private lazy var titleView = TitleContainerView()

    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.AppColors.backgroundColor
        iv.clipsToBounds = true
        iv.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        iv.layer.cornerRadius = UIConstants.cornerRadius
        return iv
    }()

    init(cornerRadius: CGFloat) {
        super.init(frame: .zero)

        setupUI(cornerRadius: cornerRadius)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(cornerRadius: CGFloat) {
        
        addSubview(titleView)
        titleView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(UIConstants.titleViewHeight)
        }
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(titleView.snp.top)
        }
    }

    public func setup(with url: URL?, title: String) {
        if url != nil {
            imageView.kf.setImage(with: url)
        }
        titleView.configure(with: title)
    }
}
