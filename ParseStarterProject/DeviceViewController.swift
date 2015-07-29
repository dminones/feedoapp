//
//  DeviceViewController.swift
//  ParseStarterProject
//
//  Created by Dario on 6/30/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DeviceViewController: UIViewController {
    var device: Device?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = device?.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        var destination = segue.destinationViewController as! FeedSettingsTableViewController
        destination.device = device!
    }


}
