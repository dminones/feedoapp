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
    var device: Device?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = device?.name
        
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
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! PFTableViewCell!
        if cell == nil {
            cell = PFTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }
        
        let feedSetting = object as! FeedSetting
        cell?.textLabel?.text = feedSetting.timeToShow()
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
        }
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
}
