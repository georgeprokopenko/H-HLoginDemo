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
        self.title = ""
    }

    @IBAction func authAction(_ sender: Any) {
        self.router.go(to: .login)
    }
    
}

