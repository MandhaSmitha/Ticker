//
//  LoginErrorMapper.swift
//  Ticker
//
//  Created by Mandha Smitha S on 12/10/18.
//  Copyright © 2018 Smitha. All rights reserved.
//

import UIKit

enum LoginErrorMapper: String, RawRepresentable {
    case accountNotFound
    case invalidCredentials
    case accountAlreadyExists
    case invalidInput
    case failedToAddAccount
    case passwordDecryptionFailed
    
    typealias RawValue = String
    var rawValue: RawValue {
        switch self {
        case .accountNotFound:
            return NSLocalizedString("Login_AccountNotFound", comment: "Account not found message")
        case .invalidCredentials:
            return NSLocalizedString("Login_InvalidCredentials", comment: "Invalid credentials")
        case .accountAlreadyExists:
            return NSLocalizedString("Signup_AccountAlreadyExists", comment: "Account already exists")
        case .invalidInput:
            return NSLocalizedString("Signup_InvalidUserInput", comment: "Invalid user input for registration")
        case .failedToAddAccount:
            return NSLocalizedString("Signup_FailedToAddAccount", comment: "Failed to create account")
        case .passwordDecryptionFailed:
            return NSLocalizedString("Login_GenericError", comment: "Generic failure error")
        }
    }
}
