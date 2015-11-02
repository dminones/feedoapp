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
    @NSManaged  var foodStatus : NSNumber?
    
    static func parseClassName() -> String {
        return "FeedoDevice"
    }
    
    func getFoodStatus() -> NSNumber {
        return (foodStatus != nil) ? foodStatus! : 0;
    }
}