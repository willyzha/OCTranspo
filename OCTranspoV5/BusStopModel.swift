//
//  Model.swift
//  OCTranspoV5
//
//  Created by Willy Zhang on 2014-12-21.
//  Copyright (c) 2014 Willy Zhang. All rights reserved.
//

import CoreData
import Foundation

class BusStopModel: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var id: String
    @NSManaged var code: Float
    @NSManaged var long: Float
    @NSManaged var lat: Float
    @NSManaged var searchTags: String
    
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
}
