//
//  Extensions.swift
//  AppModel
//
//  Created by Anton Goncharov on 13.12.2020.
//  Copyright © 2020 Anton Goncharov. All rights reserved.
//

import Foundation

extension String {
    var isNumberic: Bool {
        guard !isEmpty else { return false }
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
    }
}

public extension Optional where Wrapped == String {
    var orEmpty: String { self ?? "" }
}
