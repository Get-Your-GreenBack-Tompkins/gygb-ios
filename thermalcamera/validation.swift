//
//  validation.swift
//  thermalcamera
//
//  Created by Imani Chilongani on 29/02/2020.
//  Copyright © 2020 Get Your GreenBack Tompkins. All rights reserved.
//
var txtPassword: UITextField!
var lblPasswordValidation: UILabel!
var isPasswordValid = true

func textFieldDidChange(textField _: UITextField) {
    let attrStr = NSMutableAttributedString(
        string: "Password must be at least 8 characters, and contain at least one upper case letter, one lower case letter, and one number.",
        attributes: [
            .font: UIFont(name: "Roboto", size: 11.0) ?? UIFont.systemFont(ofSize: 11.0),
            .foregroundColor: UIColor(named: "6A6A6A"),
        ]
    )

    if let txt = txtPassword.text {
        isPasswordValid = true
        attrStr.addAttributes(setupAttributeColor(if: txt.count >= 8),
                              range: findRange(in: attrStr.string, for: "at least 8 characters"))
        attrStr.addAttributes(setupAttributeColor(if: txt.rangeOfCharacter(from: CharacterSet.uppercaseLetters) != nil),
                              range: findRange(in: attrStr.string, for: "one upper case letter"))
        attrStr.addAttributes(setupAttributeColor(if: txt.rangeOfCharacter(from: CharacterSet.lowercaseLetters) != nil),
                              range: findRange(in: attrStr.string, for: "one lower case letter"))
        attrStr.addAttributes(setupAttributeColor(if: txt.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil),
                              range: findRange(in: attrStr.string, for: "one number"))
    } else {
        isPasswordValid = false
    }

    lblPasswordValidation.attributedText = attrStr
}

func setupAttributeColor(if isValid: Bool) -> [NSAttributedString.Key: Any] {
    if isValid {
        return [NSAttributedString.Key.foregroundColor: UIColor.blue]
    } else {
        isPasswordValid = false
        return [NSAttributedString.Key.foregroundColor: UIColor(named: "6A6A6A")]
    }
}

func findRange(in baseString: String, for substring: String) -> NSRange {
    if let range = baseString.localizedStandardRange(of: substring) {
        let startIndex = baseString.distance(from: baseString.startIndex, to: range.lowerBound)
        let length = substring.count
        return NSMakeRange(startIndex, length)
    } else {
        print("Range does not exist in the base string.")
        return NSMakeRange(0, 0)
    }
}

func validateEmail(email: String?) -> String? {
    guard let trimmedText = email?.trimmingCharacters(in: .whitespacesAndNewlines) else { return nil }
    guard let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else { return nil }

    let range = NSMakeRange(0, NSString(string: trimmedText).length)
    let allMatches = dataDetector.matches(in: trimmedText,
                                          options: [],
                                          range: range)

    if allMatches.count == 1,
        allMatches.first?.url?.absoluteString.contains("mailto:") == true {
        return trimmedText
    } else {
        let alertController = UIAlertController(title: "Error", message: "Please enter a valid email address.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        alertController.present(alertController, animated: true, completion: nil)
        return nil
    }
}

func validatePassword(password: String?) -> String? {
    var errorMsg = "Password requires at least "

    if let txt = txtPassword.text {
        if txt.rangeOfCharacter(from: CharacterSet.uppercaseLetters) == nil {
            errorMsg += "one upper case letter"
        }
        if txt.rangeOfCharacter(from: CharacterSet.lowercaseLetters) == nil {
            errorMsg += ", one lower case letter"
        }
        if txt.rangeOfCharacter(from: CharacterSet.decimalDigits) == nil {
            errorMsg += ", one number"
        }
        if txt.count < 8 {
            errorMsg += ", and eight characters"
        }
    }

    if isPasswordValid {
        return password!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    } else {
        let alertController = UIAlertController(title: "Password Error", message: errorMsg, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)
        alertController.present(alertController, animated: true, completion: nil)
        return nil
    }
}
