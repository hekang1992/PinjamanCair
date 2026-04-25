//
//  LocationManager.swift
//  PinjamanCair
//
//  Created by hekang on 2026/4/24.
//

import UIKit
import CoreLocation

class LocationManager: NSObject {
    
    typealias LocationCompletion = ([String: String]?) -> Void
    
    private let locationManager = CLLocationManager()
    
    private var completion: LocationCompletion?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func getCurrentLocation(completion: @escaping LocationCompletion) {
        self.completion = completion
        
        let status = CLLocationManager().authorizationStatus
        
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .authorizedWhenInUse, .authorizedAlways:
            startUpdatingLocation()
            
        case .denied, .restricted:
            completion(nil)
            
        @unknown default:
            completion(nil)
        }
    }
    
    private func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    private func buildLocationDictionary(from location: CLLocation) -> [String: String] {
        let latitude = String(format: "%.6f", location.coordinate.latitude)
        let longitude = String(format: "%.6f", location.coordinate.longitude)
        
        LocationStorage.save(lat: latitude, lng: longitude)
        
        var dict: [String: String] = [
            "clump": "",
            "customary": "",
            "soon": "",
            "proximity": "",
            "jealous": latitude,
            "top": longitude,
            "perched": "",
            "followed": ""
        ]
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let placemark = placemarks?.first {
                dict["clump"] = placemark.administrativeArea ?? ""
                dict["soon"] = placemark.country ?? ""
                dict["customary"] = placemark.isoCountryCode ?? ""
                dict["proximity"] = placemark.name ?? placemark.thoroughfare ?? ""
                dict["perched"] = placemark.locality ?? ""
                dict["followed"] = placemark.subAdministrativeArea ?? placemark.subLocality ?? ""
            }
            self.completion?(dict)
        }
        
        return dict
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            startUpdatingLocation()
            
        case .denied, .restricted:
            completion?(nil)
            
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last, completion != nil else { return }
        
        manager.stopUpdatingLocation()
        
        _ = buildLocationDictionary(from: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
        completion?(nil)
    }
}

class LocationStorage {

    private static let key = "location_string"

    static func save(lat: String, lng: String) {
        let value = "\(lat),\(lng)"
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func getLatitude() -> String? {
        guard let value = UserDefaults.standard.string(forKey: key) else {
            return nil
        }

        let arr = value.split(separator: ",")
        guard arr.count == 2 else { return nil }

        return String(arr[0])
    }
    
    static func getLongitude() -> String? {
        guard let value = UserDefaults.standard.string(forKey: key) else {
            return nil
        }

        let arr = value.split(separator: ",")
        guard arr.count == 2 else { return nil }

        return String(arr[1])
    }
}

