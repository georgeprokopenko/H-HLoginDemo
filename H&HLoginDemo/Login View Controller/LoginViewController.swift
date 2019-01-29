//
//  LoginViewController.swift
//  H&HLoginDemo
//
//  Created by George Prokopenko on 28/01/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit

typealias LoginResultClosure = (Bool) -> ()

class LoginViewController: UIViewController {

    var loginCompletion: LoginResultClosure?
    
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private var loginService: LoginService!
    private var weatherService: WeatherService!
    
    // MARK: -
    
    class func initFromXib() -> LoginViewController {
        return LoginViewController(nibName: String(describing: LoginViewController.self), bundle: nil)
    }
    
    func configure(with factory: ServiceFactory) {
        self.loginService = factory.getLoginService()
        self.weatherService = factory.getWeatherService()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Авторизация"
        self.weatherService.getCurrentLocation()
        self.loginButton.setRounded()
        
        //self.scrollView.adjustToKeyboard()
    }

    @IBAction func loginAction(_ sender: Any) {
        weatherService.requestLocalWeather { (response, error) in
            if let forecast = response {
                ActionsPresenter.showAlert(from: self, title: "Weather",
                                           message: forecast.humanDescription())
            }
        }
    }
    
}
