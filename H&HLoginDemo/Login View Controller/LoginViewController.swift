//
//  LoginViewController.swift
//  H&HLoginDemo
//
//  Created by George Prokopenko on 28/01/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var loginTextField: InputTextFieldView!
    @IBOutlet private weak var passwordTextField: InputTextFieldView!
    @IBOutlet weak var forgotPassButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    private var loginService: LoginService!
    private var weatherService: WeatherService!
    
    // MARK: - Setup
    
    class func initFromXib() -> LoginViewController {
        return LoginViewController(nibName: String(describing: LoginViewController.self), bundle: nil)
    }
    
    func configure(with factory: ServiceFactory) {
        self.loginService = factory.getLoginService()
        self.weatherService = factory.getWeatherService()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupElements()
    }
    
    private func setupElements() {
        self.title = "Авторизация"
        
        self.loginTextField.setup(withMode: .login, validation: true)
        self.passwordTextField.setup(withMode: .password, validation: true)
        
        self.forgotPassButton.setRounded(by: 5.0)
        self.forgotPassButton.layer.borderColor = UIColor.init(white: 0.9, alpha: 1.0).cgColor
        self.forgotPassButton.layer.borderWidth = 1.0
        
        self.loginButton.setRounded(by: CGFloat.greatestFiniteMagnitude)
        self.scrollView.adjustToKeyboard()
    }
    
    // MARK: - Actions

    @IBAction func loginAction(_ sender: Any) {
        guard self.loginTextField.isValid, self.passwordTextField.isValid else {
            ActionsPresenter.showAlert(from: self, title: "Fields are not valid",
                                       message: Constants.invalidLoginFieldsMessage)
            return
        }

        weatherService.requestLocalWeather { (response, error) in
            if let forecast = response {
                ActionsPresenter.showAlert(from: self, title: "Weather",
                                           message: forecast.humanDescription())
            }
        }
    }
    
    @IBAction func forgotPassAction(_ sender: Any) {
        if let email = self.loginTextField.textField.text, !email.isEmpty {
            self.loginService.requestPasswordRecovery(with: email) { (response, error) in
            }
        } else {
            ActionsPresenter.showAlert(from: self, title: "Password recovery",
                                       message: Constants.passwordRecoveryEmailMessage)
        }
    }
    
    
}
