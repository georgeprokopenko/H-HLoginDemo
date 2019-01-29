//
//  HHAPI.swift
//  H&HLoginDemo
//
//  Created by George Prokopenko on 28/01/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import Foundation

enum HHAPI {
    case login(String, String)
    case weatherByCoords(Double, Double)
    case another
    
    var requiresAuth: Bool {
        switch self {
        case .login(_, _), .weatherByCoords(_, _):
            return false
        default:
            return true
        }
    }
    
    var baseURL: URL {
        return URL.init(string: Constants.defaultServerURL)!
    }
    
    func toString() -> String {
        var urlString = Constants.defaultServerURL
        
        switch self {
        case .weatherByCoords(let lat, let long):
            urlString += "forecast.json?key=" + Constants.weatherAPIKey + "&q=" + String(lat) + "," + String(long)
        case .login(_, _):
            urlString = ""
        case .another:
            urlString = ""
        }
    
        return urlString
    }
}
