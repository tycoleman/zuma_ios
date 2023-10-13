//
//  LocationService.swift
//  Zuma
//
//  Created by Adrian Martushev on 6/12/23.
//

//import CoreLocation
//
//class LocationService: NSObject, CLLocationManagerDelegate {
//    
//    static let shared = LocationService() // Singleton instance
//    
//    private let locationManager = CLLocationManager()
//    var currentLocation: CLLocationCoordinate2D?
//
//    private override init() {
//        super.init()
//        self.locationManager.requestWhenInUseAuthorization()
//        locationManager.delegate = self
//    }
//    
//    func start() {
//        locationManagerDidChangeAuthorization(locationManager)
//    }
//    
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        switch manager.authorizationStatus {
//        case .authorizedWhenInUse, .authorizedAlways:
//            if CLLocationManager.locationServicesEnabled() {
//                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//                locationManager.startUpdatingLocation()
//            }
//        default:
//            print("Permission denied or restricted")
//            // Handle case where user denied or restricted location services
//        }
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
//        currentLocation = locValue
//        locationManager.stopUpdatingLocation()  // stop updating location after we get a valid location
//    }
//}

import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationService() // Singleton instance
    
    private let locationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?
    
    // Add a callback for location authorization changes
    var authorizationCallback: ((CLAuthorizationStatus) -> Void)?
    
    // Add a callback for location updates
    var locationUpdateCallback: ((CLLocationCoordinate2D) -> Void)?

    private override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func start() {
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        authorizationCallback?(status)
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            if CLLocationManager.locationServicesEnabled() {
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
            }
        default:
            print("Permission denied or restricted")
            // Handle case where user denied or restricted location services
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        currentLocation = locValue
        locationUpdateCallback?(locValue)
        locationManager.stopUpdatingLocation()  // stop updating location after we get a valid location
    }
}

