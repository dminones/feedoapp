//
//  FeedSetting.swift
//  ParseStarterProject
//
//  Created by Dario on 7/24/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class FeedSettingViewController: UIViewController {
    @IBOutlet weak var datePicker : UIDatePicker?
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
}
