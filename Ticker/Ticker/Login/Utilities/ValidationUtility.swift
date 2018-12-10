//
//  ValidationUtility.swift
//  Ticker
//
//  Created by Mandha Smitha S on 12/9/18.
//  Copyright © 2018 Smitha. All rights reserved.
//

import UIKit

class ValidationUtility: NSObject {
    class func isValidName(_ name: String?) -> Bool {
        guard let nameString = name,
            nameString.count > 0 else {
                return false
        }
        return true
    }
    
    class func isValidEmail(_ email: String?) -> Bool {
        guard let emailID = email else {
            return false
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailValidityPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailValidityPredicate.evaluate(with: emailID)
    }
    
    class func isValidPassword(_ password: String?) -> Bool {
        guard let passwordString = password else {
            return false
        }
        let passwordRegEx = "^(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[!@#$%^&+=*]).{8,15}$"
        let passwordValidityPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordValidityPredicate.evaluate(with: passwordString)
    }
}
