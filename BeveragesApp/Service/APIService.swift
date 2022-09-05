//
//  APIService.swift
//  BeveragesApp
//
//  Created by Yulia Popova on 3/9/2022.
//

import Alamofire
import Foundation
import CoreData

private struct QueryConstants {
    static let beverageNameURL = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s="
    static let compositionURL = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i="
}

final class APIService {

    static let shared = APIService()
    
    func fetchBeverages(query: String,
                        completion: @escaping ([BeverageModel]?) -> Void) {

        var result: [BeverageModel] = []

        let beverageNameQuery = QueryConstants.beverageNameURL + query
        let beverageСompositionQuery = QueryConstants.compositionURL + query

        let requestGroup = DispatchGroup()

        let queue = DispatchQueue(label: "Network", attributes: .concurrent)

        [beverageNameQuery, beverageСompositionQuery].forEach { query in
            queue.async(group: requestGroup) {
                requestGroup.enter()
                AF.request(query)
                    .responseDecodable(of: [String: Set<BeverageModel>?].self) { data in
                        switch data.result {
                        case .success(let beverages):
                            for beverage in beverages {
                                if let res = beverage.value {
                                    result += res
                                    requestGroup.leave()
                                }
                            }
                        case .failure(_):
                            requestGroup.leave()
                        }
                    }
            }
        }

        requestGroup.notify(queue: .main) {
            completion(result.unique())
        }
    }
}
