//
//  WeatherResponse.swift
//  H&HLoginDemo
//
//  Created by Prokopenko Georgy on 29/01/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit

struct Location: Decodable {
    var country: String
    var city: String
    
    enum CodingKeys : String, CodingKey {
        case country, city = "name"
    }
}

struct Forecasts: Decodable {
    var forecastForDay: [Forecast]
    enum CodingKeys: String, CodingKey {
        case forecastForDay = "forecastday"
    }
}

struct Forecast: Decodable {
    var dayForecast: DayForecast

    enum CodingKeys: String, CodingKey {
        case dayForecast = "day"
    }
}

struct DayForecast: Decodable {
    var humidity: Float
    var temp: Float
    var condition: Condition
    
    enum CodingKeys: String, CodingKey {
        case humidity = "avghumidity", temp = "avgtemp_c", condition
    }
}

struct Condition: Decodable {
    var icon: String
    var text: String
}

struct WeatherResponse: Decodable {
    var location: Location
    var forecasts: Forecasts
    
    enum CodingKeys: String, CodingKey {
        case forecasts = "forecast", location
    }
}
