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

class DeviceViewController: UITableViewController {
    var device: Device?
    var configButton : UIButton?
    
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
        let destination = segue.destinationViewController as! FeedSettingsTableViewController
        destination.device = device!
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView( tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 44;
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if (section==0){
            return nil;
        }
        
        if configButton == nil {
            configButton = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 44.0))
            configButton!.backgroundColor = UIColor.whiteColor()
            configButton!.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
            configButton!.setTitle("Configurar", forState: UIControlState.Normal)
            configButton!.addTarget(self, action: "goToFeedSettingController:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        return configButton
    }
    
    
    func goToFeedSettingController(sender: UIBarButtonItem) {
        performSegueWithIdentifier("DeviceScreenToDeviceConfig", sender: nil)
    }
    

}
