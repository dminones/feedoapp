//
//  FeedSetting.swift
//  ParseStarterProject
//
//  Created by Dario on 7/24/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class FeedSettingViewController: UITableViewController {
    var datePicker : UIDatePicker = UIDatePicker()

    var feedSetting : FeedSetting = FeedSetting()
    var deleteButton : UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barButton = UIBarButtonItem(title: "Save", style: .Done, target: self, action: Selector("saveFeedSetting:"))
        self.navigationItem.rightBarButtonItem = barButton
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: Selector("cancel:"))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        
        datePicker.datePickerMode = UIDatePickerMode.Time
        datePicker.backgroundColor = UIColor.whiteColor();
        if let date = feedSetting.time {
            datePicker.date = date
        }
       
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView?.reloadData()
    }
    
    func saveFeedSetting(sender: UIBarButtonItem) {
        let date = datePicker.date
        let hourFormatter = NSDateFormatter()
        hourFormatter.locale = NSLocale(localeIdentifier:"en_US")
        hourFormatter.dateFormat = "HH"
        
        feedSetting.time = date
        LoadingOverlay.shared.showOverlay(self.view)

        feedSetting.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            if !success {
                self.showError(error)
            }
            LoadingOverlay.shared.hideOverlayView()
        }
    }
    
    func showError(error:NSError?) {
        NSLog("%@", error!)
    }
    
    func cancel(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func deleteFeedSetting(sender: UIBarButtonItem) {
        LoadingOverlay.shared.showOverlay(self.view)
        
        feedSetting.deleteInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            if !success {
                self.showError(error)
            }
            LoadingOverlay.shared.hideOverlayView()
            self.cancel(sender)
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell!
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Cell")
        }
        
        if (indexPath.row == 0) {
            cell?.textLabel?.text = "weight"
            cell?.detailTextLabel?.text = feedSetting.getWeightString()
        }else {
            cell?.textLabel?.text = "weekdays"
            cell?.detailTextLabel?.text = feedSetting.daysString()
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let identifier = (indexPath.row == 0) ? "FeedSettingToFeedWeight" : "FeedSettingToFeedDays"
        self.performSegueWithIdentifier(identifier, sender: nil)
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "FeedSettingToFeedWeight") {
            let destination = segue.destinationViewController as! FeedWeightViewController
            destination.feedSetting = self.feedSetting
        } else if (segue.identifier == "FeedSettingToFeedDays") {
            let destination = segue.destinationViewController as! DayWeeksTableViewController
            destination.feedSetting = self.feedSetting
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section==1){
            return 2
        }
        return 0
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView( tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 2 ? 44 : 0;
    }
    
    
    override func tableView( tableView: UITableView,viewForHeaderInSection section: Int) -> UIView? {
        return section == 0 ? datePicker : nil;
    }
    
    override func tableView( tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? self.datePicker.frame.height : 0;
    }

    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if (section != 2){
            return nil;
        }
        
        if deleteButton == nil {
            deleteButton = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 44.0))
            deleteButton!.backgroundColor = UIColor.whiteColor()
            deleteButton!.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
            deleteButton!.setTitle("Delete", forState: UIControlState.Normal)
            deleteButton!.addTarget(self, action: "deleteFeedSetting:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        return deleteButton
    }
}
