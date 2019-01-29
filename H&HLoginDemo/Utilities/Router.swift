//
//  Router.swift
//  H&HLoginDemo
//
//  Created by George Prokopenko on 29/01/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit

enum Scene {
    case intro
    case login
}

class Router: NSObject {
    var serviceFactory = ServiceFactory()
    var navigationController: UINavigationController?
    
    var currentViewController: RoutableViewController? {
        return navigationController?.topViewController as? RoutableViewController
    }
    
    var loginViewController: LoginViewController {
        let loginVC = LoginViewController.initFromXib()
        loginVC.configure(with: self.serviceFactory)
        return loginVC
    }
    
    func go(to scene: Scene) {
        switch scene {
        case .intro:
            self.goToIntro()
        case .login:
            self.currentViewController?.navigationController?.pushViewController(self.loginViewController, animated: true)
        }
    }
    
    private func goToIntro() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let main = UIStoryboard.init(name: "Main", bundle: nil)
        
        if let introNavVC = main.instantiateInitialViewController() as? UINavigationController,
            let introVC = introNavVC.viewControllers.first as? RoutableViewController {
            self.navigationController = introNavVC
            introVC.router = self
            introVC.configure(with: self.serviceFactory)
            
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = introNavVC
            app.window = window
            window.makeKeyAndVisible()
        }
    }
    
    func prepare(for segue: UIStoryboardSegue) {
        guard let from = segue.source as? RoutableViewController,
            let to = segue.destination as? RoutableViewController
            else { return }
        
        to.router = self
        to.configure(with: self.serviceFactory)
    }
}
