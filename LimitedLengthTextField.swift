//
//  LimitedLengthTextField.swift
//  Zuma
//
//  Created by Adrian Martushev on 9/20/23.
//

import UIKit
import Foundation
import SwiftUI



class LimitedLengthTextField: UITextField, UITextFieldDelegate {

    var characterLimit: Int = 0
    var onLimitReached: (() -> Void)?
    var nextFieldResponder: UIResponder?

    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text, text.count >= characterLimit {
            onLimitReached?()
            nextFieldResponder?.becomeFirstResponder()
        }
    }
}




struct FocusedTextField: UIViewRepresentable {
    @Binding var text: String
    let characterLimit: Int
    let onLimitReached: (() -> Void)?
    weak var nextField: LimitedLengthTextField?

    func makeUIView(context: Context) -> LimitedLengthTextField {
        let textField = LimitedLengthTextField(frame: .zero)
        textField.delegate = textField
        textField.characterLimit = characterLimit
        textField.onLimitReached = onLimitReached
        return textField
    }

    func updateUIView(_ uiView: LimitedLengthTextField, context: Context) {
        uiView.text = text
        uiView.nextFieldResponder = nextField
    }
}


