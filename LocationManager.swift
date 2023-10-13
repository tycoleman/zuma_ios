//
//  LocationManager.swift
//  Zuma
//
//  Created by Adrian Martushev on 6/13/23.
//

import Foundation
import CoreLocation


class LocationManager: NSObject, ObservableObject {
    private let manager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    
    @Published var authorizationStatus: CLAuthorizationStatus
    @Published var country: String = "Unknown"

    override init() {
        self.authorizationStatus = CLLocationManager.authorizationStatus()
        super.init()
        manager.delegate = self
    }

    func requestPermission() {
        manager.requestWhenInUseAuthorization()
    }
    
    func requestCountry() {
        manager.requestLocation()
    }
}



extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        DispatchQueue.main.async {
            self.authorizationStatus = status
            print(status)
            
            if status == .authorizedWhenInUse {
                self.requestCountry()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                if let error = error {
                    print("Failed to get country: \(error)")
                    return
                }
                
                if let country = placemarks?.first?.country {
                    DispatchQueue.main.async {
                        self.country = country
                    }
                }
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user's location: \(error)")
    }
}
