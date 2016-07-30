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
                print("\(StandardEngine.sharedInstance.rows)")
            } else {
                rowsField.textColor = UIColor.redColor()
        }
            //help unwrapping this value from http://stackoverflow.com/questions/24115141/swift-converting-string-to-int
    }
    @IBOutlet weak var colsField: UITextField!
    @IBAction func cols(sender: AnyObject) {
        let temp: Int? = (colsField.text! as NSString).integerValue
        if temp != nil && temp! >= minDimension && temp <= maxDimension{
            colsField.textColor = UIColor.blackColor()
            StandardEngine.sharedInstance.cols = temp!
        } else {
            colsField.textColor = UIColor.redColor()
        }
        
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

