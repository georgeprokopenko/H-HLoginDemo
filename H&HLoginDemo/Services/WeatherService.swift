//
//  WeatherService.swift
//  H&HLoginDemo
//
//  Created by George Prokopenko on 29/01/2019.
//  Copyright © 2019 George Prokopenko. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherService: BaseService {
    
    private var locationManager: CLLocationManager?
    private var currentLocation: CLLocation?
    private var localWeatherRequestCompletion: WeatherResponseResultClosure?
    
    override init(hhAPI: HHProvider) {
        super.init(hhAPI: hhAPI)
        self.locationManager = CLLocationManager()
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager?.requestWhenInUseAuthorization()
    }
    
    func requestLocalWeather(completionHandler: @escaping WeatherResponseResultClosure) {
        self.localWeatherRequestCompletion = completionHandler
        
        if let location = self.currentLocation {
            self.hhAPI.request(.weatherByCoords(location.coordinate.latitude, location.coordinate.longitude)) { result, error in
                if let parsedData = try? JSONDecoder().decode(WeatherResponse.self, from: result as! Data) {
                    completionHandler(parsedData, .none)
                }
                else {
                    completionHandler(nil, .unknown)
                }
            }
        }
        else {
            self.startLocationObserving()
        }
    }
    
    //MARK: -
    
    private func startLocationObserving() {
        LoadingSpinner.show()
        self.locationManager?.delegate = self
        self.locationManager?.startUpdatingLocation()
    }
    
    private func stopLocationObserving() {
        LoadingSpinner.hide()
        self.locationManager?.delegate = nil
        self.locationManager?.stopUpdatingLocation()
    }
}

extension WeatherService: CLLocationManagerDelegate {
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let lastLocation = locations.last, lastLocation.isValid() {
                self.currentLocation = lastLocation
                self.stopLocationObserving()
                print("Current location received")
                
                if let completion = self.localWeatherRequestCompletion {
                    self.requestLocalWeather(completionHandler: completion)
                }
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            self.currentLocation = nil
        }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            switch status {
            case .denied, .restricted:
                self.currentLocation = nil
            default:
                break
            }
        }
}
