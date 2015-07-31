//
//  FeedSetting.swift
//  ParseStarterProject
//
//  Created by Dario on 7/24/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class FeedSettingsTableViewController : PFQueryTableViewController {
    var device: Device = Device()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = device.name
        
        var barButton = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: Selector("addFeedSetting:"))
        self.navigationItem.rightBarButtonItem = barButton
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.loadObjects()
    }
    
    func addFeedSetting(sender: UIBarButtonItem) {
        self.goToFeedSetting(nil)
    }
    
    override func queryForTable() -> PFQuery{
        let query = FeedSetting.query()
        query!.whereKey("device", equalTo: self.device)
        return query!
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! PFTableViewCell!
        if cell == nil {
            cell = PFTableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        }
        
        let feedSetting = object as! FeedSetting
        cell?.textLabel?.text = feedSetting.timeToShow() + " - " + feedSetting.getWeightString()
        cell?.textLabel?.font = cell?.textLabel?.font.fontWithSize(30)
        cell?.detailTextLabel?.text = feedSetting.daysString()
        cell?.detailTextLabel?.font = cell?.detailTextLabel?.font.fontWithSize(14)

        return cell
    }
    
    override func tableView(tableView: UITableView,didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.goToFeedSetting(self.objectAtIndexPath(indexPath) as! FeedSetting?)
    }
    
    func goToFeedSetting(feedSetting: FeedSetting?) {
        let storyboard = UIStoryboard(name: "FeedSetting", bundle: nil)

        var modal = storyboard.instantiateViewControllerWithIdentifier("FeedSettingViewController") as! FeedSettingViewController
        var navigationController = UINavigationController(rootViewController: modal)
        if feedSetting != nil {
            modal.feedSetting = feedSetting!
        } else {
            modal.feedSetting = FeedSetting()
        }
        
        var relation = modal.feedSetting.relationForKey("device")
        relation.addObject(self.device)
        
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        if (self.tableView.editing) {
            return UITableViewCellEditingStyle.Delete;
        }
        
        return UITableViewCellEditingStyle.None;
    }
}
