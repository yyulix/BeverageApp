//
//  DetailedCardPresenter.swift
//  BeveragesApp
//
//  Created by Yulia Popova on 3/9/2022.
//

import Foundation

protocol DetailedCardPresenter {
    var view: DetailedCardViewProtocol? { get set }
    var router: BeveragesListRouter? { get set }
    var presentedBeverage: BeverageModel? { get set }

    func hideView()
    func getBeverage() -> BeverageModel?
}

final class DetailedCardPresenterImpl: DetailedCardPresenter {

    var view: DetailedCardViewProtocol?
    var router: BeveragesListRouter?
    var presentedBeverage: BeverageModel?

    init() {}

    func getBeverage() -> BeverageModel? {
        guard let presentedBeverage = presentedBeverage else { return nil }
        return presentedBeverage
    }

    func hideView() {
        view = nil
        router?.routeToBeveragesListScreen()
    }
}
