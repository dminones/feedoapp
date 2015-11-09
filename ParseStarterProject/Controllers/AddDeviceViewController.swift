//
//  AddDeviceViewController.swift
//  Feedo
//
//  Created by Dario Miñones on 11/7/15.
//  Copyright © 2015 Parse. All rights reserved.
//
import UIKit
import Parse
import QRCodeReader
import AVFoundation

class AddDeviceViewController : UIViewController {

    lazy var reader = QRCodeReaderViewController(metadataObjectTypes: [AVMetadataObjectTypeQRCode])

    override func viewDidLoad() {
        super.viewDidLoad()
        let navbar = UINavigationBar(frame: CGRectMake(0, 20,
            UIScreen.mainScreen().bounds.size.width,50));
        self.view.addSubview(navbar)
        
        let navItem = UINavigationItem(title: "Add Device")
        let navBarbutton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action:"cancel")
        navItem.rightBarButtonItem = navBarbutton
        
        navbar.items = [navItem]
    }
    
    @IBAction func goToAddDevice(sender: UIButton) {
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
    
    @IBAction func addDeviceWithCode(sender: UIButton) {
        
    }
    
    func cancel() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}