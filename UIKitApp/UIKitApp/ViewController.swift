//
//  ViewController.swift
//  UDFExample
//
//  Created by Anton Goncharov on 24.11.2020.
//

import UIKit
import UDF
import AppModel

class ViewController: UIViewController {

    var store: Store<FormState>!
    var subscription: UUID?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameErrorLabel: UILabel!

    @IBOutlet weak var pincodeTextField: UITextField!
    @IBOutlet weak var pincodeErrorLabel: UILabel!

    @IBOutlet weak var dogNameTextField: UITextField!
    @IBOutlet weak var dogNameErrorLabel: UILabel!

    @IBOutlet weak var saveButton: UIBarButtonItem!

    deinit {
        subscription = nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.addTarget(self, action: #selector(nameTextFieldDidChange), for: .editingChanged)
        pincodeTextField.addTarget(self, action: #selector(pincodeTextFieldDidChange), for: .editingChanged)
        dogNameTextField.addTarget(self, action: #selector(dogNameTextFieldDidChange), for: .editingChanged)

        subscription = store.subscribe { [weak self] state in
            self?.render(state)
        }
    }

    private func render(_ state: FormState) {
        nameTextField.text = state.name.value
        render(status: state.name.status, to: nameErrorLabel)

        pincodeTextField.text = state.pincode.value
        render(status: state.pincode.status, to: pincodeErrorLabel)

        dogNameTextField.text = state.dogName.value
        render(status: state.dogName.status, to: dogNameErrorLabel)

        saveButton.isEnabled = state.isValidForm
    }

    private func render(status: FieldStatus, to label: UILabel) {
        switch status {
        case .default, .valid:
            label.isHidden = true
        case let .tooShort(minLength):
            label.text = "Minimum \(minLength) characters"
            label.isHidden = false
        case let .tooLong(maxLength):
            label.text = "Maximum \(maxLength) characters"
            label.isHidden = false
        case .numbersOnly:
            label.text = "Only numbers allowed"
            label.isHidden = false
        }
    }

    @objc private func nameTextFieldDidChange(_ textField: UITextField) {
        store.dispatch(Actions.nameDidChange(textField.text))
    }

    @objc private func pincodeTextFieldDidChange(_ textField: UITextField) {
        store.dispatch(Actions.pincodeDidChange(textField.text))
    }

    @objc private func dogNameTextFieldDidChange(_ textField: UITextField) {
        store.dispatch(Actions.dogNameDidChange(textField.text))
    }
}
