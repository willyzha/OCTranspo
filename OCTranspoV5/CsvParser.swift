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
        /*
        let managedContext = appDelegate.managedObjectContext!
        
        let entity =  NSEntityDescription.insertNewObjectForEntityForName("StopTime",inManagedObjectContext:managedContext) as StopTimeModel
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
*/
        let path = NSBundle.mainBundle().pathForResource("stop_times", ofType: "txt")

        if let p = path{
            let csvURL = NSURL(fileURLWithPath: p)
            println(p)
            var error2: NSErrorPointer = nil
        
            if let c = csvURL {
                println(c)
                let comma = NSCharacterSet(charactersInString: ",")
                let csv = CSV(contentsOfURL: c, delimiter: comma,error: error2)!
                println(error2)
                println(csv.headers)
            }
        }

        /*
        let csvURL = NSURL(string: "test.csv")
        
        println(csvURL?.absoluteString)
        
        var error: NSErrorPointer = nil
        let csv = CSV(contentsOfURL: csvURL!, error: error)
        
        println(csv?.headers)
        */
    }
    
}