//
//  ServiceFactory.swift
//  H&HLoginDemo
//
//  Created by George Prokopenko on 28/01/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import Foundation

class ServiceFactory: NSObject {

    private var hhAPI = HHProvider()
    
    func getLoginService() -> LoginService {
        return LoginService(hhAPI: self.hhAPI)
    }
    
    func getWeatherService() -> WeatherService {
        return WeatherService(hhAPI: self.hhAPI)
    }
    
}
