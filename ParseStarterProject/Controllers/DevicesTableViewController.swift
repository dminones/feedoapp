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


class DevicesTableViewController: PFQueryTableViewController, PFLogInViewControllerDelegate{

    var imageView : UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        let barButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: Selector("addDevice:"))
        self.navigationItem.rightBarButtonItem = barButton
        
        let image: UIImage = UIImage(named: "image-smartfeeder_dog.png")!
        imageView = UIImageView(image: image)
        imageView!.frame = CGRectMake(0,0,self.view.frame.size.width,200)
        imageView?.contentMode = .ScaleAspectFill
        self.tableView.reloadData()
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
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath)
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
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
        self.performSegueWithIdentifier("DeviceListToAddDevice", sender: nil)
    }
    
    override func tableView( tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (imageView?.frame.size.height)!;
    }
    
    override func tableView( tableView: UITableView,viewForHeaderInSection section: Int) -> UIView? {
        return imageView;
    }
}
