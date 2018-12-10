//
//  EncryptedStringTransformer.swift
//  Ticker
//
//  Created by Mandha Smitha S on 12/11/18.
//  Copyright © 2018 Smitha. All rights reserved.
//

import UIKit
import RNCryptor

class EncryptedStringTransformer: ValueTransformer {
    
    override func transformedValue(_ value: Any?) -> Any? {
        let password = "y4H?t/Dg:B"
        guard let valueToEncrypt = value as? String,
            let data = valueToEncrypt.data(using: .utf8) else {
            return nil
        }
        let cipherText = RNCryptor.encrypt(data: data, withPassword: password)
        return cipherText
    }
    
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        let password = "y4H?t/Dg:B"
        guard value != nil, let data = value as? Data else {
            return nil
        }
        do {
            let originalData = try RNCryptor.decrypt(data: data, withPassword: password)
            return String(bytes: originalData, encoding: .utf8)
        } catch {
            return nil
        }
    }
}
