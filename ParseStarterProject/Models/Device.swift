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
    @NSManaged  var lastFeeding : NSDate?
    @NSManaged var sensorClose : NSNumber?
    
    var configData = ["foodStatus", "lastFeeding", "sensorClose"]
    var configLabels = ["Status", "Last Feeding", "Sensor Closed"]
    
    static func parseClassName() -> String {
        return "FeedoDevice"
    }
    
    func getPrintableValue(key: String) -> String {
        switch key {
            case "lastFeeding":
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "d/M hh:mm" //format style. Browse online to get a format that fits your needs.
                return dateFormatter.stringFromDate(self.lastFeeding!)
            case "sensorClose":
                return ((self.sensorClose != nil) && (self.sensorClose != 0)) ? "yes" : "no"
            default:
                if let value = self.valueForKey(key) {
                    return value.stringValue
                }
                return ""
        }
    }
    
    func getFoodStatus() -> NSNumber {
        return (foodStatus != nil) ? foodStatus! : 0;
    }
}