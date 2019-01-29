//
//  ActionsPresenter.swift
//  H&HLoginDemo
//
//  Created by Prokopenko Georgy on 29/01/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit

class ActionsPresenter: NSObject {

    class func showAlert(from: UIViewController,
                         title: String,
                         message: String,
                         style: UIAlertControllerStyle = .alert,
                         actions: [UIAlertAction] = [okAction],
                         completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach { alert.addAction($0) }
        from.present(alert, animated: true, completion: completion)
    }
    
    private class var okAction: UIAlertAction {
        return UIAlertAction(title: "Ok", style: .default, handler: nil)
    }
}
