//
//  CLLocation+Extensions.swift
//  H&HLoginDemo
//
//  Created by George Prokopenko on 29/01/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocation {

    func isValid() -> Bool {
        if self.coordinate.latitude > 0, self.coordinate.longitude > 0 {
            return true
        }
        else {
            return false
        }
    }
    
}
