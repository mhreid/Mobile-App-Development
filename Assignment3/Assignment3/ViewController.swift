//
//  ViewController.swift
//  Assignment3
//
//  Created by Micah Reid on 7/7/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    

    
    @IBOutlet weak var gridView: GridView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func button(sender: AnyObject) {
        
        gridView.step()
    }


}

