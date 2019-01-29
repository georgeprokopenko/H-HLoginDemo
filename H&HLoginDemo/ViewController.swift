//
//  ViewController.swift
//  H&HLoginDemo
//
//  Created by George Prokopenko on 28/01/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit

class ViewController: RoutableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.router.go(to: .login)
    }

}

