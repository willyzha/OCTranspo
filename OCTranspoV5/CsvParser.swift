//
//  CsvParser.swift
//  OCTranspoV5
//
//  Created by Willy Zhang on 2014-12-23.
//  Copyright (c) 2014 Willy Zhang. All rights reserved.
//

import Foundation
import CoreData
import SwiftCSV

struct CsvParser {
    static func parsesStopTimes(appDelegate: AppDelegate){
        
        //let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        
        let entity =  NSEntityDescription.insertNewObjectForEntityForName("StopTime",inManagedObjectContext:managedContext) as StopTimeModel
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }

        let csvURL = NSURL(string: "stop_times.txt")
        var error2: NSErrorPointer = nil
        
        if let c = csvURL {
            let csv = CSV(contentsOfURL: c, error: error2)!
        
            println(csv.headers)
        }
        
    }
}