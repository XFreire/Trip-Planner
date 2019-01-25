//
//  TextFieldAutocompler.swift
//  Core
//
//  Created by Alexandre Freire on 24/01/2019.
//  Copyright © 2019 Alexandre Freire. All rights reserved.
//

import Foundation

final class TextFieldAutoCompleter: NSObject, UITextFieldDelegate {
    
    // MARK: Properties
    var suggestions = [City]()
    var didChangeText: (UITextField) -> Void = { _ in }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return !autoCompleteText(in : textField, using: string, suggestions: suggestions)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func autoCompleteText(in textField: UITextField, using string: String, suggestions: [String]) -> Bool {
        let theString = string.capitalized
        if !theString.isEmpty,
            let selectedTextRange = textField.selectedTextRange,
            selectedTextRange.end == textField.endOfDocument,
            let prefixRange = textField.textRange(from: textField.beginningOfDocument, to: selectedTextRange.start),
            let text = textField.text( in : prefixRange) {
            let prefix = text + theString
            let matches = suggestions.filter {
                $0.lowercased().hasPrefix(prefix.lowercased())
            }
            if (matches.count > 0) {
                textField.text = matches[0]
                didChangeText(textField)
                if let start = textField.position(from: textField.beginningOfDocument, offset: prefix.count) {
                    textField.selectedTextRange = textField.textRange(from: start, to: textField.endOfDocument)
                    
                    return true
                }
            }
        }
        return false
    }
}
