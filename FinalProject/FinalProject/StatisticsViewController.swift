//
//  StatisticsViewController.swift
//  FinalProject
//
//  Created by Micah Reid on 7/28/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//

import UIKit

class StatisticsViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        AliveLabel.text = ("Alive: \(StandardEngine.sharedInstance.grid.alive)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var AliveLabel: UILabel!

    @IBOutlet weak var BornLabel: UILabel!
    
    @IBOutlet weak var EmptyLabel: UILabel!
    
    @IBOutlet weak var DiedLabel: UILabel!
}
