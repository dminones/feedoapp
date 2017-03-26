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
        
        let barButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: Selector("addFeedSetting:"))
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
        
        // If no objects are loaded in memory, we look to the cache first to fill the table
        // and then subsequently do a query against the network.
        if self.objects!.count == 0 {
            query!.cachePolicy = .CacheThenNetwork
        }
        
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

        let separator = CALayer()
        separator.backgroundColor = UIColor.lightGrayColor().CGColor
        separator.frame = CGRectMake(15, 80, self.view.frame.size.width-15, 1);
        cell?.layer.addSublayer(separator)
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator

        return cell
    }
    
    override func tableView(tableView: UITableView,didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.goToFeedSetting(self.objectAtIndexPath(indexPath) as! FeedSetting?)
    }
    
    func goToFeedSetting(feedSetting: FeedSetting?) {
        let storyboard = UIStoryboard(name: "FeedSetting", bundle: nil)

        let modal = storyboard.instantiateViewControllerWithIdentifier("FeedSettingViewController") as! FeedSettingViewController
        let navigationController = UINavigationController(rootViewController: modal)
        if feedSetting != nil {
            modal.feedSetting = feedSetting!
        } else {
            modal.feedSetting = FeedSetting()
        }
        
        let relation = modal.feedSetting.relationForKey("device")
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
