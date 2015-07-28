//
//  FeedSetting.swift
//  ParseStarterProject
//
//  Created by Dario on 7/24/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class FeedSettingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var datePicker : UIDatePicker?
    @IBOutlet weak var tableView : UITableView?

    var feedSetting : FeedSetting = FeedSetting()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var barButton = UIBarButtonItem(title: "Save", style: .Done, target: self, action: Selector("saveFeedSetting:"))
        self.navigationItem.rightBarButtonItem = barButton
        
        var cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: Selector("cancel:"))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        if var date = feedSetting.time {
            datePicker?.date = date
        }
       
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView?.reloadData()
    }
    
    func saveFeedSetting(sender: UIBarButtonItem) {
        var date = datePicker!.date
        var hourFormatter = NSDateFormatter()
        hourFormatter.locale = NSLocale(localeIdentifier:"en_US")
        hourFormatter.dateFormat = "HH"
        
        feedSetting.time = date
        
        NSLog("Time: " + feedSetting.timeToShow())
        
        feedSetting.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            if success {
                NSLog("Object created with id: (feedSetting.objectId)")
            } else {
                NSLog("%@", error!)
            }
        }
    }
    
    func cancel(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! UITableViewCell!
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        }
        
        if (indexPath.row == 0) {
            cell?.textLabel?.text = feedSetting.weight?.stringValue.stringByAppendingString(" gr")
        }else {
            cell?.textLabel?.text = feedSetting.daysString()
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        if (indexPath.row == 0) {
            var controller = self.storyboard?.instantiateViewControllerWithIdentifier("FeedWeightViewController") as! FeedWeightViewController
            controller.feedSetting = self.feedSetting
            self.navigationController?.pushViewController(controller, animated: true)
        }else {
            var controller = self.storyboard?.instantiateViewControllerWithIdentifier("FeedWeightViewController") as! FeedWeightViewController
            controller.feedSetting = self.feedSetting
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
}
