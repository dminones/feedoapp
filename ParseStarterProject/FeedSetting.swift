//
//  FeedSetting.swift
//  ParseStarterProject
//
//  Created by Dario on 7/24/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import Parse

class FeedSetting: PFObject, PFSubclassing {
    @NSManaged  var time : NSDate?
    @NSManaged  var weight : NSNumber?
    
    static func parseClassName() -> String {
        return "FeedSetting"
    }
    
    func timeToShow() -> String {
        var formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier:"en_US")
        formatter.dateFormat = "HH:mm"
        
        
        if var time=self.time {
            return formatter.stringFromDate(time)
        }
        return "No Date"
    }
    
    func daysString() -> String {
        return "Todos los dias"
    }
}