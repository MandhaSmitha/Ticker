
//
//  CustomTextField.swift
//  Ticker
//
//  Created by Mandha Smitha S on 4/8/19.
//  Copyright © 2019 Smitha. All rights reserved.
//
import UIKit

@IBDesignable
class CustomTextField: UITextField {
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}
