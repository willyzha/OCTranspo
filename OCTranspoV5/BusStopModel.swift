//
//  Model.swift
//  OCTranspoV5
//
//  Created by Willy Zhang on 2014-12-21.
//  Copyright (c) 2014 Willy Zhang. All rights reserved.
//

import CoreData
import Foundation
import CoreLocation

class BusStopModel: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var id: String
    @NSManaged var code: Float
    @NSManaged var long: Float
    @NSManaged var lat: Float
    @NSManaged var searchTags: String
    
    var distance: Double = 0.0
    
    
    func getId() -> String {
        return id
    }
    
    func getLatitude() -> String {
        return "\(self.lat)"
    }
    
    func getLongtitude() -> String {
        return "\(self.long)"
    }
    
    func getName() -> String {
        return self.name.substringWithRange(Range<String.Index>(start: advance(self.name.startIndex, 1), end: advance(self.name.endIndex, -1)))
    }
    
    func getCodeAsInt() -> Int{
        return Int(code)
    }
    
    func getCodeAsString() -> String{
        return String(getCodeAsInt())
    }
    
    func getTag() -> String {
        return searchTags
    }
    
    func toString() -> String{
        return "id:  \(getId())\ncode:  \(getCodeAsString())\nname:  \(getName())\nlat:   \(getLatitude())\nlon:   \(getLongtitude())\ntag:   \(getTag())"
    }
    
    func searchMatch(searchText: String) -> Bool{
        let result: Bool = (self.searchTags.rangeOfString(searchText.lowercaseString) != nil)
        
        return result
    }
    
    // GSP Related Function Below
    
    func getCLLocationLatitude() -> CLLocationDegrees{
        return Double(self.lat)
    }
    
    func getCLLocationLontitude() -> CLLocationDegrees{
        return Double(self.long)
    }
    
    func getCLLocation() -> CLLocation{
        return CLLocation(latitude: getCLLocationLatitude(), longitude: getCLLocationLontitude())
    }
    
    func getDistance(location: CLLocation?) -> CLLocationDistance?{
        if let l = location{
            return self.getCLLocation().distanceFromLocation(location)
        }
        return nil
    }
    
    func getDistanceAsString(location: CLLocation) -> String {
        return "\(self.getDistance(location))"
    }
    
    func setDistanceAttribute(location: CLLocation){
        if let d = getDistance(location) {
            self.distance = d
        }
    }
}
