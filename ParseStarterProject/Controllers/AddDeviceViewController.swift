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
    var deviceCode : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add Device"
        let navBarbutton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action:"cancel")
        self.navigationItem.leftBarButtonItem = navBarbutton
    }
    
    @IBAction func goToAddDevice(sender: UIButton) {
        if (QRCodeReader.isAvailable()) {
            // Or by using the closure pattern
            reader.completionBlock = { (result: String?) in
                self.reader.dismissViewControllerAnimated(true, completion: nil)
                if (result != nil) {
                    self.deviceCode = result!
                    self.switchToSetName()
                } else {
                    self.cancel()
                }
            }
            
            // Presents the reader as modal form sheet
            reader.modalPresentationStyle = .FormSheet
            presentViewController(reader, animated: true, completion: nil)
        } else {
            NSLog("Pongo un texto");
        }
    }
    
    func switchToSetName() {
        let viewController = storyboard!.instantiateViewControllerWithIdentifier("SelectDeviceNameViewController") as! SelectDeviceNameViewController
        viewController.deviceCode = self.deviceCode
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    func cancel() {
        self.navigationController!.dismissViewControllerAnimated(true, completion: nil)
    }

}