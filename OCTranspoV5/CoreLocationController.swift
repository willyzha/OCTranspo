//
//  CoreLocationController.swift
//  OCTranspoV2
//
//  Created by Willy Zhang on 2014-12-18.
//  Copyright (c) 2014 Willy Zhang. All rights reserved.
//

import Foundation
import CoreLocation

class CoreLocationController : NSObject, CLLocationManagerDelegate {
    var locationManager:CLLocationManager = CLLocationManager()
    var location: CLLocation = CLLocation()
    var locationListeners: [LocationListener] = []
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.distanceFilter  = 1000 // Must move at least 3km
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer // Accurate within a kilometer
        self.locationManager.requestAlwaysAuthorization()
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        println("didChangeAuthorizationStatus")
        
        switch status {
        case .NotDetermined:
            println(".NotDetermined")
            break
            
        case .Authorized:
            println(".Authorized")
            self.locationManager.startUpdatingLocation()
            break
        case .Denied:
            println(".Denied")
            break
            
        default:
            println("Unhandled authorization status")
            break
            
        }
    }
    
    func getLocation() -> String{
        return "lat: \(location.coordinate.latitude) lon: \(location.coordinate.longitude)"
    }
    
    func getCLLocation() -> CLLocation{
        return location
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        let location = locations.last as CLLocation
        
        //lat = location.coordinate.latitude.
        self.location = location
        
        
        println("didUpdateLocations:  \(location.coordinate.latitude), \(location.coordinate.longitude)")
        
        self.locationUpdate()
    }
    
    func registerLocationListener(listener: LocationListener){
        self.locationListeners.append(listener)
    }
    
    func locationUpdate(){
        for ll in locationListeners{
            ll.locationUpdated(self.location)
        }
    }
}