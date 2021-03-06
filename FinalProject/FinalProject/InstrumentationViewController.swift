//
//  FirstViewController.swift
//  FinalProject
//
//  Created by Micah Reid on 7/28/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//

import UIKit
import Foundation

class InstrumentationViewController: UIViewController {
    let maxDimension = 60
    let minDimension = 10
    let fetcher: Fetcher = Fetcher()
    static let instrumentation: InstrumentationViewController = InstrumentationViewController()
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
    @IBOutlet weak var newName: UITextField!

    @IBAction func addRow(sender: AnyObject) {
        StandardEngine.sharedInstance.names.append(newName.text!)
        StandardEngine.sharedInstance.tableContents[newName.text!] = [[]]
        StandardEngine.sharedInstance.editPoints = []
        StandardEngine.sharedInstance.editRow = StandardEngine.sharedInstance.names.count - 1
        self.performSegueWithIdentifier("toMove", sender: self)

    }
    

    @IBOutlet weak var URL: UITextField!
    
    @IBOutlet weak var go: UIButton!
    var url =  NSURL( string: "https://dl.dropboxusercontent.com/u/7544475/S65g.json")
    //NSURL(string: URL.text!)!
    @IBAction func sendURL(sender: AnyObject) {
        //this makes it so it doesn't crash when you enter an emoji
        print(StandardEngine.sharedInstance.names)

        if let JSONurl: NSURL = NSURL(string: URL.text!){
            
            fetcher.requestJSON(JSONurl) { (json, message) in
                if let json = json,
                    dict = json as? Array<Dictionary<String,AnyObject>> {
                    StandardEngine.sharedInstance.names = []
                    _ = dict.reduce(0){
                        if let name = $1["title"] as? String, points = $1["contents"] as? [[Int]]{
                            StandardEngine.sharedInstance.names.append(name)
                            StandardEngine.sharedInstance.tableContents[name] = points
                        }
                        return 1
                    }
                    let op = NSBlockOperation {
                        TableViewController.tableView.tableView.reloadData()
                    }
                    NSOperationQueue.mainQueue().addOperation(op)
                }
                
            }
        } else {
            print("that's an emoji")
        }
        
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 2 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.performSegueWithIdentifier( "toMove", sender: self)
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
    

