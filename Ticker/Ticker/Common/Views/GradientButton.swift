//
//  GradientButton.swift
//  Ticker
//
//  Created by Mandha Smitha S on 4/8/19.
//  Copyright © 2019 Smitha. All rights reserved.
//

import UIKit

@IBDesignable
class GradientButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setGradeient(button: self)
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
    
    private func setGradeient(button: UIButton) {
        let gradient = CAGradientLayer()
        gradient.frame = button.bounds
        gradient.colors = [
            UIColor(red:0.95, green:0.88, blue:0.69, alpha:1).cgColor,
            UIColor(red:0.98, green:0.71, blue:0.04, alpha:1).cgColor
        ]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        gradient.cornerRadius = 4
        button.layer.insertSublayer(gradient, at: 0)
    }
}
