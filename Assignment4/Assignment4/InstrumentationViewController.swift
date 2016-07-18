//
//  FirstViewController.swift
//  Assignment4
//
//  Created by Micah Reid on 7/15/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//
//All Icons From https://icons8.com/

import UIKit

class InstrumentationViewController: UIViewController {

    @IBOutlet weak var refresh: UISlider!{
        didSet{
            StandardEngine.init(rows: Int(rows.text!)!, cols: Int(cols.text!)!, refreshRate: Double(refresh.value))
        }
    }
    @IBOutlet weak var rows: UITextField!{
        didSet{
            Grid.init(rows: Int(rows.text!)!, cols: Int(cols.text!)!)
            StandardEngine.init(rows: Int(rows.text!)!, cols: Int(cols.text!)!, refreshRate: Double(refresh.value))
            
        }
    }
    
    @IBOutlet weak var cols: UITextField!{
        didSet{
            Grid.init(rows: Int(rows.text!)!, cols: Int(cols.text!)!)
            StandardEngine.init(rows: Int(rows.text!)!, cols: Int(cols.text!)!, refreshRate: Double(refresh.value))
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

