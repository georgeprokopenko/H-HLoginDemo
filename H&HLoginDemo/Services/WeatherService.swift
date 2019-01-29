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
    
    override init(hhAPI: HHProvider) {
        super.init(hhAPI: hhAPI)
        self.locationManager = CLLocationManager()
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager?.requestWhenInUseAuthorization()
        self.startLocationObserving()
    }
    
    func getCurrentLocation() {
        self.startLocationObserving()
    }
    
    func requestLocalWeather(completionHandler: @escaping WeatherResponseResultClosure) {
        if let location = self.currentLocation {
            self.hhAPI.request(.weatherByCoords(location.coordinate.latitude, location.coordinate.longitude)) {(result, error) in
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
        self.locationManager?.delegate = self
        self.locationManager?.startUpdatingLocation()
    }
    
    private func stopLocationObserving() {
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
