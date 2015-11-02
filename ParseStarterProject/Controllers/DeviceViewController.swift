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
    var deleteButton : UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = device?.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! FeedSettingsTableViewController
        destination.device = device!
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0 {
            return (device?.configData.count)!
        }
        
        if section == 1 {
            return 1
        }
        
        // Delete button on footer 0 rows
        return 0
    }
    
    override func tableView( tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section != 2 ? 0 : 44;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell!
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Cell")
        }
        
        if indexPath.section == 1 {
            cell?.textLabel?.text = "configuration"
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            return cell
        }
        
        let key = device?.configData[indexPath.row]
        if key != nil {
            cell?.textLabel?.text = key
            if let value = device!.valueForKey(key!) {
                cell?.detailTextLabel?.text = value.stringValue
            }
        }
      
        return cell
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if (section==0){
            return nil;
        }
        
        if deleteButton == nil {
            deleteButton = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 44.0))
            deleteButton!.backgroundColor = UIColor.whiteColor()
            deleteButton!.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
            deleteButton!.setTitle("Delete", forState: UIControlState.Normal)
            deleteButton!.addTarget(self, action: "deleteDevice:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        return deleteButton
    }
    
    override func tableView(tableView: UITableView,didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            self.goToFeedSettingController()
            return
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    func showError(error:NSError?) {
        NSLog("%@", error!)
    }
    
    func cancel(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func deleteDevice(sender: UIBarButtonItem) {
        LoadingOverlay.shared.showOverlay(self.view)
        
        self.device!.deleteInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            if !success {
                self.showError(error)
            }
            LoadingOverlay.shared.hideOverlayView()
            self.cancel(sender)
        }
    }
    
    func goToFeedSettingController() {
        performSegueWithIdentifier("DeviceScreenToDeviceConfig", sender: nil)
    }
    

}
