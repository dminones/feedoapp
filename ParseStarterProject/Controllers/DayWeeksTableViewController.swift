//
//  DayWeeksTableViewController.swift
//  ParseStarterProject
//
//  Created by Dario on 7/28/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class DayWeeksTableViewController: UITableViewController {
    var feedSetting : FeedSetting = FeedSetting()
    var lastSelectedIndexPath : NSIndexPath?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FeedSetting.weekDays.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell!
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }
        cell?.textLabel?.text = FeedSetting.weekDays[indexPath.row]
        
        if self.feedSetting.hasWeekDay(NSNumber(integer: indexPath.row)) {
            cell?.accessoryType = .Checkmark
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let newCell = tableView.cellForRowAtIndexPath(indexPath)
        
        if self.feedSetting.hasWeekDay(NSNumber(integer: indexPath.row)) {
            self.feedSetting.removeWeekDay(indexPath.row)
            newCell?.accessoryType = .None
        } else {
            self.feedSetting.addWeekDay(indexPath.row)
            newCell?.accessoryType = .Checkmark
        }
    }
}
