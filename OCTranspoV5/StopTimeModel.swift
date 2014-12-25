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
    
    func createStopTimeModel(tripId: String, arrivalTime: String, departureTime: String, stopId: String, stopSequence: Int16, pickupType: Int16, dropOffType: Int16){
        self.tripId = tripId
        self.arrivalTime = arrivalTime
        self.departureTime = departureTime
        self.stopId = stopId
        self.stopSequence = stopSequence
        self.pickupType = pickupType
        self.dropOffType = dropOffType
    }
    
    func toString() -> String {
        return "tripId: \(tripId)\narrivalTime: \(arrivalTime)\ndepartureTime: \(departureTime)\nstopId: \(stopId)\nstopSequence: \(stopSequence)\npickupType: \(pickupType)\ndropOffType: \(dropOffType)"
    }
}