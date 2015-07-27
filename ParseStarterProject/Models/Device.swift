//
//  Device.swift
//  ParseStarterProject
//
//  Created by Dario on 7/24/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import Parse

class Device: PFObject, PFSubclassing {
    @NSManaged  var name : String
    
    static func parseClassName() -> String {
        return "FeedoDevice"
    }
}