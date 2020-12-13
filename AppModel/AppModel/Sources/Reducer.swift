//
//  Reducer.swift
//  AppModel
//
//  Created by Anton Goncharov on 06.12.2020.
//

import Foundation
import UDF

public func reduce(state: inout FormState, action: Action) {
    if case let Actions.nameDidChange(name) = action {
        update(name: &state.name, with: name)
        update(isValidForm: &state)
    }

    if case let Actions.pincodeDidChange(pincode) = action {
        update(pincode: &state.pincode, with: pincode)
        update(isValidForm: &state)
    }

    if case let Actions.dogNameDidChange(dogName) = action {
        update(dogName: &state.dogName, with: dogName)
        update(isValidForm: &state)
    }
}

private func update(name: inout Field, with value: String?) {
    name.value = value

    let nameLength = value?.count ?? 0
    let minNameLength = 5
    name.status = nameLength >= minNameLength ? .valid : .tooShort(minLength: minNameLength)
}

private func update(pincode: inout Field, with value: String?) {
    pincode.value = value

    let value = value ?? ""
    pincode.status = value.isNumberic ? .valid : .numbersOnly
}

private func update(dogName: inout Field, with value: String?) {
    dogName.value = value

    let dogNameLength = value?.count ?? 0
    let maxDogNameLength = 3
    dogName.status = dogNameLength <= maxDogNameLength ? .valid : .tooLong(maxLength: maxDogNameLength)
}

private func update(isValidForm state: inout FormState) {
    state.isValidForm = checkValidStatus(of: [state.name, state.pincode, state.dogName])
}

private func checkValidStatus(of fields: [Field]) -> Bool {
    fields.allSatisfy { $0.status.isValid }
}
