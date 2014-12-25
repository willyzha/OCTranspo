//
//  File.swift
//  OCTranspoV5
//
//  Created by Willy Zhang on 2014-12-21.
//  Copyright (c) 2014 Willy Zhang. All rights reserved.
//

import Foundation
import CoreData

struct FileReader {
    
    static func readFromFile(fileName: String, fileExtension: String) -> String?{
        
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: fileExtension)
        var possibleContent = String(contentsOfFile:path!, encoding: NSUTF8StringEncoding, error: nil)
               
        
        return possibleContent
    }
    
    static func parseBusStopCSV(fileName: String, fileExtension: String) -> [BusStop]{
        let data = readFromFile(fileName, fileExtension: fileExtension)
        
        var output: [BusStop] = []
        if let d = data{
            output = parseBusStopCSV(d)
        }
        return output
    }
    
    static func parseBusStopCSV(CSV: String) -> [BusStop]{
        
        
        var myStringArr = CSV.componentsSeparatedByString("\n")
        var busStops: [BusStop] = []
        
        for str in myStringArr {
            //println("arr \(str)")
            
            if str.rangeOfString(",") != nil {
                if str.rangeOfString("stop_id") == nil{
                var seperatedStr = str.componentsSeparatedByString(",")
                
                let id: String = seperatedStr[0]
                let code: Float = (seperatedStr[1] as NSString).floatValue
                let name: String = seperatedStr[2]
                let lat: Float = (seperatedStr[4] as NSString).floatValue
                let long: Float = (seperatedStr[5] as NSString).floatValue
                
                busStops.append(BusStop(id: id, code: code, name: name, lat: lat, long: long))
                }
            }
            
        }
        
        for stop in busStops {
            println(stop.toString())
            
        }
        
        return busStops
    }
    
    static func parseStopTimesCSV(fileName: String, fileExtension: String, appDelegate: AppDelegate) -> [StopTimeModel]{
        let data = readFromFile(fileName, fileExtension: fileExtension)
        
        var output: [StopTimeModel] = []
        if let d = data{
            output = parseStopTimesCSV(d, appDelegate: appDelegate)
        }
        return output
    }

    
    static func parseStopTimesCSV(CSV: String, appDelegate: AppDelegate) -> [StopTimeModel]{
        
        var myStringArr = CSV.componentsSeparatedByString("\n")
        
        var stopTimes: [StopTimeModel] = []
        
        
        
        for str in myStringArr {
            if str.rangeOfString("trip_id") == nil{
                
                let managedContext = appDelegate.managedObjectContext!
                
                //2
                let entity =  NSEntityDescription.insertNewObjectForEntityForName("StopTime",inManagedObjectContext:managedContext) as StopTimeModel
 
                var s = str.componentsSeparatedByString(",")
                
                entity.createStopTimeModel(s[0], arrivalTime: s[1], departureTime: s[2], stopId: s[3], stopSequence: Int16(s[4].toInt()!), pickupType: Int16(s[5].toInt()!), dropOffType: Int16(s[6].toInt()!))
                
                println(entity.toString())
                
                stopTimes.append(entity)
            }
        }
        
        println("DONE")
        return stopTimes
    }
    
}