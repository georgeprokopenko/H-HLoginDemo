//
//  UIButton+Extensions.swift
//  H&HLoginDemo
//
//  Created by George Prokopenko on 29/01/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setRounded(by radius: CGFloat) {
        if radius == CGFloat.greatestFiniteMagnitude {
            self.layer.cornerRadius = self.bounds.size.height/2
        }
        else {
            self.layer.cornerRadius = radius
        }
        
    }
}
