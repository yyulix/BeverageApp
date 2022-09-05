//
//  BeveragesListPresenter.swift
//  BeveragesApp
//
//  Created by Yulia Popova on 3/9/2022.
//

import Foundation

protocol BeveragesListPresenter {

    var router: BeveragesListRouter? { get set }
    var interactor: BeveragesListInteractor? { get set }
    var view: BeveragesListView? { get set }

    func inputFieldUpdated(with text: String?)

    func beveragesWereFetched(_ beverages: [BeverageModel]?)

    func beverageWasSelected(with index: Int)

    func goToMainScreen()

    func getBeverage(with index: Int) -> BeverageModel?
    func getAmountOfBeverages() -> Int
}

final class BeveragesListPresenterImpl: BeveragesListPresenter {

    var router: BeveragesListRouter?
    var view: BeveragesListView?
    var interactor: BeveragesListInteractor?

    var beverages: [BeverageModel] = []

    private var counter: Timer?
    private var query: String = ""

    private let timeInterval = 1.0

    func inputFieldUpdated(with text: String?) {

        if (counter != nil) {
            counter?.invalidate()
            counter = nil
        }

        guard let text = text else {
            return
        }

        query = text.trim()
        counter = Timer.scheduledTimer(timeInterval: timeInterval,
                                       target: self,
                                       selector: #selector(sendRequest),
                                       userInfo: text, repeats: false)
    }

    @objc func sendRequest() {
        interactor?.getBeverages(query: query)
    }

    func beverageWasSelected(with index: Int) {
        view?.pushTranslucentSubstrate()
        router?.routeToDetailedCardScreen(beverages[index])
    }

    func beveragesWereFetched(_ beverages: [BeverageModel]?) {
        if let beverages = beverages, !beverages.isEmpty {
            self.beverages = beverages
            view?.updateCollectionView()
        } else {
            view?.notifyUser(with: NSLocalizedString("networkError", comment: ""))
        }
    }

    func getBeverage(with index: Int) -> BeverageModel? {
        if beverages.count > index { return beverages[index] }
        return nil
    }

    func getAmountOfBeverages() -> Int {
        beverages.count
    }

    func goToMainScreen() {
        view?.popTranslucentSubstrate()
    }
}
