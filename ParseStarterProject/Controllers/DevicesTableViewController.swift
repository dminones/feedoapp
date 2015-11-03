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
import QRCodeReader
import AVFoundation

class DevicesTableViewController: PFQueryTableViewController, PFLogInViewControllerDelegate{
    
    lazy var reader = QRCodeReaderViewController(metadataObjectTypes: [AVMetadataObjectTypeQRCode])

    override func viewDidLoad() {
        super.viewDidLoad()
        let barButton = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: Selector("addDevice:"))
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.loadObjects()
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        NSLog("Login")
        logInController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func logInViewControllerDidCancelLogIn(logInController: PFLogInViewController) {
        NSLog("Cancel")
    }
    
    override func tableView(tableView: UITableView,didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("DeviceViewController") as! DeviceViewController
        next.device = self.objectAtIndexPath(indexPath) as! Device?
        self.navigationController?.pushViewController(next, animated: true)
    }
    
    override func queryForTable() -> PFQuery{
        let query = Device.query()
        
        // If no objects are loaded in memory, we look to the cache first to fill the table
        // and then subsequently do a query against the network.
        if self.objects!.count == 0 {
            query!.cachePolicy = .CacheThenNetwork
        }
        
        return query!
    }
    
    
    func addDevice(sender: UIBarButtonItem) {
        
        if (QRCodeReader.isAvailable()) {
            // Or by using the closure pattern
            reader.completionBlock = { (result: String?) in
                if (result != nil) {
                    NSLog(result!)
                }
                self.reader.dismissViewControllerAnimated(true, completion: nil)
            }
            
            // Presents the reader as modal form sheet
            reader.modalPresentationStyle = .FormSheet
            presentViewController(reader, animated: true, completion: nil)
        } else {
            NSLog("Pongo un texto");
        }
        
    }
}
