//
//  StringExtension.swift
//  BeveragesApp
//
//  Created by Yulia Popova on 3/9/2022.
//

import Foundation

extension String {
    func toURL() -> URL? {
        return URL(string: self.replacingOccurrences(of: "\\", with: "")) ?? nil
    }

    func trim() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
}
