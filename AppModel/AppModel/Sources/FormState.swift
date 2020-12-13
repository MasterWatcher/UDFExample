//
//  State.swift
//  AppModel
//
//  Created by Anton Goncharov on 06.12.2020.
//

import Foundation

public struct FormState {
    public var name: Field
    public var pincode: Field
    public var dogName: Field
    public var isValidForm: Bool

    public init() {
        name = .init()
        pincode = .init()
        dogName = .init()
        isValidForm = false
    }
}

public struct Field {
    public var value: String?
    public var status: FieldStatus = .default
}

public enum FieldStatus {
    case `default`
    case valid
    case tooShort(minLength: Int)
    case tooLong(maxLength: Int)
    case numbersOnly
}
public extension FieldStatus {
    var isValid: Bool {
        if case .valid = self {
            return true
        } else {
            return false
        }
    }
}
