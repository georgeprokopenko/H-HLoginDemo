//
//  BaseService.swift
//  H&HLoginDemo
//
//  Created by George Prokopenko on 29/01/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit

typealias RequestObjectResultClosure = (AnyObject?, HHAPIError) -> ()
typealias WeatherResponseResultClosure = (WeatherResponse?, HHAPIError) -> ()

class BaseService: NSObject {

    var hhAPI: HHProvider
    
    init(hhAPI: HHProvider) {
        self.hhAPI = hhAPI
    }
    
}
