//
//  ContentView.swift
//  SwiftUIApp
//
//  Created by Anton Goncharov on 13.12.2020.
//  Copyright © 2020 Anton Goncharov. All rights reserved.
//

import SwiftUI
import UDF
import AppModel

struct ContentView: View {

    @EnvironmentObject
    var store: SwiftUIStore<FormState>

    func statusToError(_ status: FieldStatus) -> String? {
        switch status {
        case .default, .valid:
            return nil
        case let .tooShort(minLength):
            return "Minimum \(minLength) characters"
        case let .tooLong(maxLength):
            return "Maximum \(maxLength) characters"
        case .numbersOnly:
            return "Only numbers allowed"
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                FieldView(
                    label: "Name",
                    text: store.binding(get: { $0.name.value.orEmpty }, send: Actions.nameDidChange),
                    error: statusToError(store.state.name.status))
                FieldView(
                    label: "Pincode",
                    text: store.binding(get: { $0.pincode.value.orEmpty }, send: Actions.pincodeDidChange),
                    error: statusToError(store.state.pincode.status))
                FieldView(
                    label: "Dog's name",
                    text: store.binding(get: { $0.dogName.value.orEmpty }, send: Actions.dogNameDidChange),
                    error: statusToError(store.state.dogName.status))
                Spacer()
            }
            .padding(16)
            .navigationBarTitle("Some Form", displayMode: .inline)
            .navigationBarItems(
                trailing:
                Button(action: {}) {
                    Text("Save")
                }
                .disabled(!store.state.isValidForm)
            )
        }
    }
}

struct FieldView: View {

    var label: String
    @Binding var text: String
    var error: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            TextField(label, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            if error != nil {
                Text(error.orEmpty)
                    .font(.system(size: 12))
                    .foregroundColor(.red)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
