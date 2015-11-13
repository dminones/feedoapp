//
//  SelectDeviceNameViewController.swift
//  Feedo
//
//  Created by Dario Miñones on 11/13/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit
import Parse

class SelectDeviceNameViewController: UIViewController {

    var device : Device?
    var deviceCode: String?
    @IBOutlet var textField : UITextField?
    @IBOutlet var label : UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action:"dismiss")
        self.navigationItem.leftBarButtonItem = cancelButton
        self.title = "Select Name"
        
        if (deviceCode == nil) {
            self.dismiss()
        }
        
        self.fetchDevice()
    }
    
    func setupTextView() {
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.darkGrayColor().CGColor
        border.frame = CGRect(x: 0, y: textField!.frame.size.height - width, width:  textField!.frame.size.width, height: textField!.frame.size.height)
        
        border.borderWidth = width
        self.textField?.hidden = false
        textField!.layer.addSublayer(border)
        textField!.layer.masksToBounds = true
        self.textField?.becomeFirstResponder()
    }
    
    func fetchDevice() {
        let query = Device.query()
        query!.whereKey("code", equalTo: self.deviceCode!)
        query?.getFirstObjectInBackgroundWithBlock({ (object: PFObject?, error: NSError?) -> Void in
            if error == nil {
                if let device = object as? Device {
                    self.setupTextView()
                    self.device = device
                    self.label?.text = "Select the name you want to use to identify your device."
                    let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action:"done")
                    self.navigationItem.rightBarButtonItem = doneButton
                }
            } else {
                self.errorOnFetch()
            }
            
        })

    }
    
    func errorOnFetch() {
        let alert = UIAlertController(title: "Device not founded", message:"Seems like you haven't linked your feedo yet", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in self.dismiss()
        }
        let retryAction = UIAlertAction(title: "Retry", style: UIAlertActionStyle.Default) {
            UIAlertAction in self.fetchDevice()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(retryAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismiss() {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func done() {
        device!.name = (textField?.text)!
        LoadingOverlay.shared.showOverlay(self.view)
        device!.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            LoadingOverlay.shared.hideOverlayView()
            if !success {
                self.showError(error,title: "Cannot Save", message: "Please try again later")
            } else {
                self.dismiss() 
            }
        }
    }
    
    func showError(error:NSError?, title:String, message:String) {
        NSLog("%@",error!)
        
        let alert = UIAlertController(title: title, message:message, preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
        }
        
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
