//
//  BeverageModel.swift
//  BeveragesApp
//
//  Created by Yulia Popova on 3/9/2022.
//

import Foundation

class BeverageModel: NSObject, NSCoding, Decodable {

    let strDrinkThumb: String
    let strDrink: String

    init(strDrinkThumb: String, strDrink: String) {
        self.strDrinkThumb = strDrinkThumb
        self.strDrink = strDrink
    }

    required convenience init(coder aDecoder: NSCoder) {
        let strDrinkThumb = aDecoder.decodeObject(forKey: "strDrinkThumb") as! String
        let strDrink = aDecoder.decodeObject(forKey: "strDrink") as! String
        self.init(strDrinkThumb: strDrinkThumb, strDrink: strDrink)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(strDrink, forKey: "strDrink")
        aCoder.encode(strDrinkThumb, forKey: "strDrinkThumb")
    }
}
