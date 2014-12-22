//
//  BusStop.swift
//  OCTranspoV5
//
//  Created by Willy Zhang on 2014-12-21.
//  Copyright (c) 2014 Willy Zhang. All rights reserved.
//

import Foundation

class BusStop: NSObject{
    var name: String
    var id: String
    var code: Float
    var long: Float
    var lat: Float
    
    init(id: String, code: Float, name: String, lat: Float, long: Float){
        self.name = name
        self.id = id
        self.code = code
        self.long = long
        self.lat = lat
    }
    
    func getName() -> String{
        return self.name
    }
    
    func getCode() -> Float{
        return self.code
    }
    
    func getId() -> String{
        return self.id
    }
    
    func getCoord() -> (Float, Float){
        return(self.lat, self.long)
    }
    
    func getLat() -> Float{
        return self.lat
    }
    
    func getLong() -> Float{
        return self.long
    }
    
    func toString() -> String{
        return "id: \(self.id) code: \(self.code) name: \(self.name) latitude: \(self.lat) longtitude: \(self.long)"
    }
}