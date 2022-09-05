//
//  BeveragesListRouter.swift
//  BeveragesApp
//
//  Created by Yulia Popova on 3/9/2022.
//

import UIKit

protocol BeveragesListRouter {
    var entryPoint: (BeveragesListView & UIViewController)? { get }

    func start()

    func routeToDetailedCardScreen(_ beverage: BeverageModel)
    func routeToBeveragesListScreen()
}

final class BeveragesListRouterImpl: BeveragesListRouter {

    var entryPoint: (BeveragesListView & UIViewController)?

    var transitionHandler: UIViewController?
    var beveragesListPresenter: BeveragesListPresenter?
    var devailedView: DetailedCardViewProtocol?
    var detailedCardPresenter: DetailedCardPresenter?

    func routeToDetailedCardScreen(_ beverage: BeverageModel) {
        assemblyDetailModule()
        guard let devailedView = devailedView as? DetailedCardViewController else { return }

        detailedCardPresenter?.presentedBeverage = beverage

        devailedView.modalPresentationStyle = .overCurrentContext
        devailedView.modalTransitionStyle = .coverVertical
        transitionHandler?.present(devailedView, animated: true)
    }

    func routeToBeveragesListScreen() {
        detailedCardPresenter = nil
        devailedView = nil
        beveragesListPresenter?.goToMainScreen()
    }

    func start() {
        beveragesListPresenter = BeveragesListPresenterImpl()

        var beveragesListView: BeveragesListView = BeveragesListController()
        var beveragesListInteractor: BeveragesListInteractor = BeveragesListInteractorImpl()

        transitionHandler = beveragesListView as? BeveragesListController
        self.entryPoint = beveragesListView as? (BeveragesListView & UIViewController)

        beveragesListView.presenter = beveragesListPresenter
        beveragesListInteractor.presenter = beveragesListPresenter
        beveragesListPresenter?.router = self
        beveragesListPresenter?.view = beveragesListView
        beveragesListPresenter?.interactor = beveragesListInteractor
    }

    func assemblyDetailModule() {
        detailedCardPresenter = DetailedCardPresenterImpl()
        devailedView = DetailedCardViewController()
        devailedView?.detailedPresenter = detailedCardPresenter
        detailedCardPresenter?.view = devailedView
        detailedCardPresenter?.router = self
    }
}
