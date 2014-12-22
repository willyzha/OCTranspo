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
    
    func getName() -> String {
        return self.name.substringWithRange(Range<String.Index>(start: advance(self.name.startIndex, 1), end: advance(self.name.endIndex, -1)))
    }
    
    func getCodeAsInt() -> Int{
        return Int(code)
    }
    
    func getCodeAsString() -> String{
        return String(getCodeAsInt())
    }
    
    
}
