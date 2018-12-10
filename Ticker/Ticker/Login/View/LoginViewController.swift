//
//  LoginViewController.swift
//  Ticker
//
//  Created by Mandha Smitha S on 12/9/18.
//  Copyright © 2018 Smitha. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var errorLabel: UILabel!
    lazy var viewModel: LoginViewModel? = {
        return LoginViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        view.endEditing(true)
        errorLabel.text = nil
        viewModel?.login(email: emailTextField.text, password: passwordTextField.text, completionHandler: {
            (isSuccess, errorMessage) in
            DispatchQueue.main.async { [weak self] in
                self?.handleLoginResponse(isSuccess: isSuccess, errorMessage: errorMessage)
            }
        })
    }
    
    func handleLoginResponse(isSuccess: Bool, errorMessage: String?) {
        if isSuccess == false {
            errorLabel.text = errorMessage
        } else {
            showTickerViewController()
        }
    }
    
    func showTickerViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TickerViewController")
        guard let tickerViewController = storyboard as? TickerViewController else {
            return
        }
        tickerViewController.viewModel = TickerViewModel(service: BitPoloniexService())
        self.navigationController?.show(tickerViewController, sender: nil)
    }
}

extension LoginViewController: UITextFieldDelegate {    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
