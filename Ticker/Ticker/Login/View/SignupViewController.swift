//
//  SignupViewController.swift
//  Ticker
//
//  Created by Mandha Smitha S on 12/9/18.
//  Copyright © 2018 Smitha. All rights reserved.
//

import UIKit
import Lottie

class SignupViewController: UIViewController {
    lazy var viewModel: SignupViewModel? = {
        return SignupViewModel()
    }()
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailIdTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var lottieView: AnimationView!

    override func viewDidLoad() {
        super.viewDidLoad()
        animateIcon()
    }
    
    func animateIcon() {
        let starAnimation = Animation.named("coin")
        lottieView.animation = starAnimation
        lottieView.loopMode = .loop
        lottieView.play()
    }
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapSignup(_ sender: UIButton) {
        view.endEditing(true)
        errorLabel.text = nil
        let signupInput = SignupInputModel(firstName: firstNameTextField.text,
                                           lastName: lastNameTextField.text,
                                           emailID: emailIdTextField.text,
                                           password: passwordTextField.text)
        viewModel?.signup(signupInput: signupInput, completionHandler: {
            (isSuccess, errorMessage) in
            DispatchQueue.main.async { [weak self] in
                self?.handleSignupResponse(isSuccess: isSuccess, errorMessage: errorMessage)
            }
        })
    }
    
    func handleSignupResponse(isSuccess: Bool, errorMessage: String?) {
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

extension SignupViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
