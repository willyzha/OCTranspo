//
//  StopTimeModel.swift
//  OCTranspoV5
//
//  Created by Willy Zhang on 2014-12-23.
//  Copyright (c) 2014 Willy Zhang. All rights reserved.
//

import Foundation
import CoreData

class StopTimeModel: NSManagedObject {
    @NSManaged var tripId: String
    @NSManaged var arrivalTime: String
    @NSManaged var departureTime: String
    @NSManaged var stopId: String
    @NSManaged var stopSequence: Int16
    @NSManaged var pickupType: Int16
    @NSManaged var dropOffType: Int16
    
}