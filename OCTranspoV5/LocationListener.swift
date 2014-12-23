//
//  LocationListener.swift
//  OCTranspoV5
//
//  Created by Willy Zhang on 2014-12-23.
//  Copyright (c) 2014 Willy Zhang. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationListener{
    func locationUpdated(CLLocation)
}