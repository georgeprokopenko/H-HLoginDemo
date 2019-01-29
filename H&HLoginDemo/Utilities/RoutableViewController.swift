//
//  RoutableViewController.swift
//  H&HLoginDemo
//
//  Created by George Prokopenko on 29/01/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit

class RoutableViewController: UIViewController {

    var router: Router!
    
    func configure(with factory: ServiceFactory) { }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.prepare(for: segue)
    }

}
