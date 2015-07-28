//
//  FeedSetting.swift
//  ParseStarterProject
//
//  Created by Dario on 7/24/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
import Parse

extension Array {
    func contains<T where T : Equatable>(obj: T) -> Bool {
        return self.filter({$0 as? T == obj}).count > 0
    }
}

class FeedSetting: PFObject, PFSubclassing {
    @NSManaged  var time : NSDate?
    @NSManaged  var weight : NSNumber?
    @NSManaged  var days : NSMutableArray?
    static let weekDays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
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
        var result = ""
        var workingDays = [1,2,3,4,5]
        
        if var currentWeekDays = days {
            if currentWeekDays.count == 7 {
                return "Todos los dias"
            }
            
            for day in currentWeekDays{
                result += FeedSetting.weekDays[day.integerValue] + " "
            }
        }
        
        return result=="" ? "Nunca" : result
    }
    
    func getWeightString() -> String {
        if var weight = self.weight {
            return weight.stringValue.stringByAppendingString(" gr")
        }
        return "0 gr"
    }
    
    func addWeekDay(weekDay: NSNumber) {
        if !self.hasWeekDay(weekDay){
            days!.addObject(weekDay)
        }
    }
    
    func removeWeekDay(weekDay: NSNumber) {
        if self.hasWeekDay(weekDay){
            days!.removeObject(weekDay)
        }
    }
    
    func hasWeekDay(weekDay: NSNumber) -> Bool{
        if days == nil {
            days = NSMutableArray()
        }
        
        return days!.containsObject(weekDay)
    }
}