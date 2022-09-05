//
//  DetailedCardViewController.swift
//  BeveragesApp
//
//  Created by Yulia Popova on 3/9/2022.
//

import UIKit

protocol DetailedCardViewProtocol {
    var detailedPresenter: DetailedCardPresenter? { get set }
}

final class DetailedCardViewController: UIViewController, DetailedCardViewProtocol {

    private struct UIConstants {
        static let cardViewHeight: CGFloat = 342.0
        static let cardViewCornerRadius: CGFloat = 20.0
        static let cardTitleViewHeight: CGFloat = 58.0
    }

    private lazy var cardView: DetailedCardView = {
        let view = DetailedCardView(cornerRadius: UIConstants.cardViewCornerRadius)
        return view
    }()

    var detailedPresenter: DetailedCardPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        if let beverage = detailedPresenter?.getBeverage() {
            cardView.setup(with: beverage.strDrinkThumb.toURL() ?? nil,
                           title: beverage.strDrink)
        }
    }

    private func setupUI() {
        view.addSubview(cardView)

        cardView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaInsets.bottom).inset(10.0)

            make.top.equalTo(view.snp.bottom).offset(UIConstants.cardViewHeight * -1)
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touches.forEach {
            let yCoord = $0.location(in: view).y
            if yCoord < view.frame.height - UIConstants.cardViewHeight {
                detailedPresenter?.hideView()
                dismiss(animated: true)
            }
        }
    }
}
