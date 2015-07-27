//
//  DevicesTableViewController.swift
//  ParseStarterProject
//
//  Created by Dario on 6/30/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class DevicesTableViewController: PFQueryTableViewController, PFLogInViewControllerDelegate {
       
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        NSLog("Login")
        logInController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func logInViewControllerDidCancelLogIn(logInController: PFLogInViewController) {
        NSLog("Cancel")
    }
    
    override func tableView(tableView: UITableView,didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var next = self.storyboard?.instantiateViewControllerWithIdentifier("DeviceViewController") as! DeviceViewController
        next.device = self.objectAtIndexPath(indexPath) as! Device?
        self.navigationController?.pushViewController(next, animated: true)
    }
}
