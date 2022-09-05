//
//  BeveragesListInteractor.swift
//  BeveragesApp
//
//  Created by Yulia Popova on 3/9/2022.
//

import Foundation
import UIKit
import SwiftyJSON

protocol BeveragesListInteractor {
    var presenter: BeveragesListPresenter? { get set }
    func getBeverages(query: String)
}

final class BeveragesListInteractorImpl: BeveragesListInteractor {

    static let service = APIService.shared

    var presenter: BeveragesListPresenter?

    func getBeverages(query: String) {

        let userDefaults = UserDefaults.standard

        if userDefaults.data(forKey: query) == nil {
            BeveragesListInteractorImpl.service.fetchBeverages(query: query) {
                let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: $0)
                userDefaults.set(encodedData, forKey: query)
                self.presenter?.beveragesWereFetched($0)
            }
        } else {
            let encodedBeverages = userDefaults.data(forKey: query)!
            let decodedBeverages = NSKeyedUnarchiver.unarchiveObject(with: encodedBeverages) as! [BeverageModel]
            self.presenter?.beveragesWereFetched(decodedBeverages)
        }
    }
}
