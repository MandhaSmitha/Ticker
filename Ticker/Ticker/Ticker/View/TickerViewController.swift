//
//  TickerViewController.swift
//  Ticker
//
//  Created by Mandha Smitha S on 12/9/18.
//  Copyright © 2018 Smitha. All rights reserved.
//

import UIKit
import Lottie

enum TickerViewType {
    case defaultTicker
    case customTicker
}

class TickerViewController: UIViewController {
    @IBOutlet weak var defaultTickerView: UIView!
    @IBOutlet weak var defaultTickerLabel: UILabel!
    @IBOutlet weak var defaultTickerImageView: UIImageView!
    @IBOutlet weak var customTickerView: UIView!
    @IBOutlet weak var customTickerLabel: UILabel!
    @IBOutlet weak var customTickerImageView: UIImageView!
    @IBOutlet weak var stockPriceTextField: UITextField!
    @IBOutlet weak var userInputView: UIView!
    @IBOutlet weak var lottieView: AnimationView!
    var tradePrice: String? {
        didSet {
            updateTicker()
        }
    }
    var isChangePositive = false
    var currentTickerViewType: TickerViewType = .defaultTicker
    var viewModel: TickerViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDataClosures()
        animateIcon()
    }
    
    func animateIcon() {
        let starAnimation = Animation.named("coin")
        lottieView.animation = starAnimation
        lottieView.loopMode = .loop
        lottieView.play()
    }
    func setDataClosures() {
        viewModel?.updateTickerData = { [weak self] (tradePrice, isPositive) -> Void in
            self?.updateTickerData(tradePrice: tradePrice, isPositive: isPositive)
        }
    }
    
    @IBAction func didTapCheckPrice(_ sender: UIButton) {
        guard let price = stockPriceTextField.text,
            let value = Double(price) else {
            return
        }
        viewModel?.setReferencePrice(value)
        viewModel?.getData(forSymbol: 1002)
        lottieView.stop()
        userInputView.isHidden = true
    }
    
    @IBAction func didTapSwitch(_ sender: UIButton) {
        currentTickerViewType = currentTickerViewType == .defaultTicker ? .customTicker : .defaultTicker
        updateTicker()
    }
    
    @IBAction func didTapLogout(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func updateTickerData(tradePrice price: String, isPositive: Bool) {
        tradePrice = price
        isChangePositive = isPositive
    }
    
    func updateTicker() {
        switch currentTickerViewType {
        case .defaultTicker:
            defaultTickerView.isHidden = false
            customTickerView.isHidden = true
            defaultTickerLabel.text = tradePrice
            defaultTickerImageView.image = isChangePositive == true ? UIImage(named: "UpArrow") : UIImage(named: "DownArrow")
        case .customTicker:
            defaultTickerView.isHidden = true
            customTickerView.isHidden = false
            customTickerLabel.text = tradePrice
            customTickerImageView.image = isChangePositive == true ? UIImage(named: "UpArrow") : UIImage(named: "DownArrow")
        }
    }
}

extension TickerViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
