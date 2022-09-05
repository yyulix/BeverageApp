//
//  InputField.swift
//  BeveragesApp
//
//  Created by Yulia Popova on 3/9/2022.
//

import UIKit

final class InputField: UIView, UITextFieldDelegate {

    private struct UIConstants {
        static let height = 25.0
        static let horizontalPadding = 10.0
    }

    private struct Styles {
        static let backgroundColor = UIColor.AppColors.backgroundColor
        static let textColor = UIColor.black
        static let placeholderColor = UIColor.AppColors.placeholderColor
        static let shadowColor = UIColor.AppColors.shadowColor.cgColor
        static let cornerRadius = 10.0
        static let shadowRadius = 16.0

    }

    internal lazy var textField: UITextField = {
        var field = UITextField()
        field.autocorrectionType = .no
        field.textColor = Styles.textColor
        return field
    }()

    init(keyboardType: UIKeyboardType = .default) {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.snp.makeConstraints { make in
            make.height.equalTo(UIConstants.height)
        }

        addSubview(textField)

        textField.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }

        let placeholder = NSMutableAttributedString(string: NSLocalizedString("coctailName", comment: ""))
        placeholder.addAttribute(.foregroundColor,
                                 value: Styles.placeholderColor,
                                 range: NSRange(location: 0,
                                                length: placeholder.length))
        textField.attributedPlaceholder = placeholder

        backgroundColor = Styles.backgroundColor
        layer.cornerRadius = Styles.cornerRadius
        layer.shadowColor = Styles.shadowColor
        layer.shadowRadius = Styles.shadowRadius
        layer.shadowOffset = CGSize(width: 1, height: 4)
        layer.shadowOpacity = 1

    }
}
