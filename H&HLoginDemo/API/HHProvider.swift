//
//  HHProvider.swift
//  H&HLoginDemo
//
//  Created by George Prokopenko on 28/01/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import Foundation
import Alamofire

class HHProvider: NSObject {
    
    func request(_ target: HHAPI, completionHandler: @escaping RequestObjectResultClosure) {
        Alamofire.request(target.toString()).responseJSON { (response) in
            if response.data != nil {
                completionHandler(response.data as AnyObject, .none)
            }
        }
    }
}
