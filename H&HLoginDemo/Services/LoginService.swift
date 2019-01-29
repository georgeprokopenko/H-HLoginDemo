//
//  LoginService.swift
//  H&HLoginDemo
//
//  Created by George Prokopenko on 28/01/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit

class LoginService: BaseService {
    
    override init(hhAPI: HHProvider) {
        super.init(hhAPI: hhAPI)
    }
    
    func requestPasswordRecovery(with email: String, completionHandler: @escaping RequestObjectResultClosure) {
        self.hhAPI.request(.forgotPassword(email)) { result, error in
            if result != nil {
                completionHandler(result, .none)
            } else {
                completionHandler(nil, .unknown)
            }
        }
    }
    
}
