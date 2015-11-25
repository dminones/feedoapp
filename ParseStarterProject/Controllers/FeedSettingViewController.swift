//
//  FeedSetting.swift
//  ParseStarterProject
//
//  Created by Dario on 7/24/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class FeedSettingViewController: UITableViewController , UIPickerViewDataSource, UIPickerViewDelegate {
    var datePicker : UIDatePicker = UIDatePicker()
    var pickerView : UIPickerView = UIPickerView()
    var editingWeight : Bool = Bool()
    var editingTime : Bool = Bool()
    var pickerViewFrame : CGRect?
    var pickerData : NSMutableArray = []
    
    var feedSetting : FeedSetting = FeedSetting()
    var deleteButton : UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barButton = UIBarButtonItem(barButtonSystemItem: .Save,target:self, action:"saveFeedSetting:")
        self.navigationItem.rightBarButtonItem = barButton
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancel:")
        self.navigationItem.leftBarButtonItem = cancelButton

        self.initDatePicker()
        self.initWeightData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView?.reloadData()
    }
    
    func initDatePicker() {
        datePicker.hidden = true
        datePicker.datePickerMode = UIDatePickerMode.Time
        datePicker.backgroundColor = UIColor.whiteColor();
        
        if feedSetting.time == nil {
            feedSetting.time = NSDate()
        }
        datePicker.date = feedSetting.time!
    }
    
    func initWeightData() {
        
        for var i = 0; i<2000; i = i+50 {
            pickerData.addObject(i)
        }
        
        var j = 0
        var selected = 0
        
        for value in self.pickerData {
            if value.isEqual(feedSetting.getWeight()) {
                selected = j
            }
            j++
        }
        
        
        pickerViewFrame = pickerView.frame
        pickerView.hidden = true
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.selectRow(selected, inComponent: 0, animated: false)
    }
    
    func saveFeedSetting(sender: UIBarButtonItem) {
        
        LoadingOverlay.shared.showOverlay(self.view.superview!)

        feedSetting.saveInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            LoadingOverlay.shared.hideOverlayView()
            if !success {
                self.showError(error,title: "Cannot Save", message: "Please try again later")
            } else {
                self.dismissViewControllerAnimated(true, completion: nil)
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
    
    func cancel(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func deleteFeedSetting(sender: UIBarButtonItem) {
        LoadingOverlay.shared.showOverlay(self.view.superview!)
        
        feedSetting.deleteInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
            LoadingOverlay.shared.hideOverlayView()

            if !success {
                self.showError(error,title: "Failed Deleting", message: "Please try again later")
            } else {
                self.cancel(sender)
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell!
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Cell")
        }
        
        switch indexPath.row {
            case 0:
                cell?.textLabel?.text = "time"
                cell?.detailTextLabel?.text = feedSetting.timeToShow()
                cell.accessoryType = .None
            case 1:
                cell.contentView.addSubview(self.datePicker)
            case 2:
                cell?.textLabel?.text = "weight"
                cell?.detailTextLabel?.text = feedSetting.getWeightString()
                cell.accessoryType = .None
            case 3:
                cell.contentView.addSubview(self.pickerView)
            default:
                cell?.textLabel?.text = "repeat"
                cell?.detailTextLabel?.text = feedSetting.daysString()
                cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row == 4) {
            self.performSegueWithIdentifier("FeedSettingToFeedDays", sender: nil)
        }
        
        if (indexPath.row == 0) {
            self.hidePickerView(pickerView)
            editingWeight = false
            //toogle
            editingTime = !editingTime
            
            //is just hidden the first time
            datePicker.hidden = false
            if (editingTime) {
                self.showPickerView(datePicker)
            } else {
                let date = datePicker.date
                let hourFormatter = NSDateFormatter()
                hourFormatter.locale = NSLocale(localeIdentifier:"en_US")
                hourFormatter.dateFormat = "HH"
                
                feedSetting.time = date
                self.pickerViewFrame = datePicker.frame;
                self.hidePickerView(datePicker)

            }
            self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
        
        if (indexPath.row == 2) {
            self.hidePickerView(datePicker)
            editingTime = false
            //toogle
            editingWeight = !editingWeight
            
            //is just hidden the first time
            pickerView.hidden = false
            if (editingWeight) {
                self.showPickerView(pickerView)
            } else {
                self.pickerViewFrame = pickerView.frame;
                self.hidePickerView(pickerView)
            }
            self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    func hidePickerView(picker: UIView) {
        
        UIView.animateWithDuration(0.3) { () -> Void in
            var frame = picker.frame
            frame.size.height = 0
            picker.frame = frame
        }
    }
    
    func showPickerView(picker: UIView) {
        UIView.animateWithDuration(0.3) { () -> Void in
            picker.frame = self.pickerViewFrame!
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! DayWeeksTableViewController
        destination.feedSetting = self.feedSetting
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section==1){
            return 5
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row == 3) {
            return editingWeight ? (self.pickerViewFrame?.height)! : 0
        }
        if(indexPath.row == 1) {
            return editingTime ? (self.pickerViewFrame?.height)! : 0
        }
        return self.tableView.rowHeight;
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView( tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 1 ? 44 : 0;
    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if (section != 2){
            return nil;
        }
        
        if deleteButton == nil {
            deleteButton = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 44.0))
            deleteButton!.backgroundColor = UIColor.whiteColor()
            deleteButton!.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
            deleteButton!.setTitle("Delete", forState: UIControlState.Normal)
            deleteButton!.addTarget(self, action: "deleteFeedSetting:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        return deleteButton
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
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (pickerData[row] as? NSNumber)?.stringValue.stringByAppendingString(" gr")
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        feedSetting.weight = pickerData[row] as? NSNumber
    }
}
