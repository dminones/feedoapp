//
//  SelectDeviceNameViewController.swift
//  Feedo
//
//  Created by Dario Miñones on 11/13/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class SelectDeviceNameViewController: UIViewController {

    var device: Device?
    @IBOutlet var textView : UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action:"dismiss")
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action:"done")
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationItem.leftBarButtonItem = cancelButton
        self.title = "Select Name"
        
        if (device == nil) {
            self.dismiss()
        }
        
        self.textView?.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismiss() {
        self.navigationController?.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func done() {
        device!.name = (textView?.text)!
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
