//
//  Functions.swift
//  MyLocations
//
//  Created by Hector Enrique Gomez Morales on 1/16/15.
//  Copyright (c) 2015 Hector Enrique Gomez Morales. All rights reserved.
//

import Foundation
import Dispatch

func afterDelay(seconds: Double, closure: () -> ()) {
    let when = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
    
    dispatch_after(when, dispatch_get_main_queue(), closure)
}
