//
//  FirstViewController.swift
//  FinalProject
//
//  Created by Micah Reid on 7/28/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//

import UIKit

class InstrumentationViewController: UIViewController {
    let maxDimension = 40
    let minDimension = 15
    
    @IBOutlet weak var rowsField: UITextField!
    @IBAction func rows(sender: AnyObject) {
            let temp: Int? = (rowsField.text! as NSString).integerValue
            if temp != nil && temp! >= minDimension && temp <= maxDimension{
                rowsField.textColor = UIColor.blackColor()
                StandardEngine.sharedInstance.rows = temp!
                rowStepper.value = Double(StandardEngine.sharedInstance.rows)
            } else {
                rowsField.textColor = UIColor.redColor()
        }
            //help unwrapping this value from http://stackoverflow.com/questions/24115141/swift-converting-string-to-int
    }
    
    @IBOutlet weak var rowStepper: UIStepper!
    @IBAction func rowsStepper(sender: AnyObject) {
        
            StandardEngine.sharedInstance.rows = Int(rowStepper.value)
            rowsField.text = String(StandardEngine.sharedInstance.rows)
        rowsField.textColor = UIColor.blackColor()

    }
    
    @IBOutlet weak var colsField: UITextField!
    @IBAction func cols(sender: AnyObject) {
        let temp: Int? = (colsField.text! as NSString).integerValue
        if temp != nil && temp! >= minDimension && temp <= maxDimension{
            colsField.textColor = UIColor.blackColor()
            StandardEngine.sharedInstance.cols = temp!
            colStepper.value = Double(StandardEngine.sharedInstance.cols)

        } else {
            colsField.textColor = UIColor.redColor()
        }
        
    }
    @IBOutlet weak var colStepper: UIStepper!
    
    @IBAction func colStepper(sender: AnyObject) {
        StandardEngine.sharedInstance.cols = Int(colStepper.value)
        colsField.text = String(StandardEngine.sharedInstance.cols)
        colsField.textColor = UIColor.blackColor()
    }
    
    @IBOutlet weak var timeSlider: UISlider!
    
    @IBAction func timeSlider(sender: AnyObject) {
        StandardEngine.sharedInstance.refreshRate = Double(10 - timeSlider.value)
    }
    
    @IBOutlet weak var refreshSwitch: UISwitch!
    
    @IBAction func refreshSwitch(sender: AnyObject) {
        StandardEngine.sharedInstance.on = refreshSwitch.on
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

