//
//  FeedWeightViewController.swift
//  ParseStarterProject
//
//  Created by Dario on 7/27/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class FeedWeightViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    var feedSetting : FeedSetting = FeedSetting()
    @IBOutlet weak var pickerView : UIPickerView?
    var pickerData : NSMutableArray = []
    
    func initPickerData() {
        for var i = 0; i<2000; i = i+50 {
            pickerData.addObject(i)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initPickerData()
    }
    
    override func viewWillAppear(animated: Bool) {
        var j = 0
        var selected = 0
        
        for value in self.pickerData {
            if value.isEqual(feedSetting.weight) {
                selected = j
            }
            j++
        }
        
        pickerView?.selectRow(selected, inComponent: 0, animated: false)
        super.viewWillAppear(animated)
    }
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return (pickerData[row] as? NSNumber)?.stringValue.stringByAppendingString(" gr")
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       feedSetting.weight = pickerData[row] as? NSNumber
    }
}
