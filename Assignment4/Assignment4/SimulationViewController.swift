//
//  SecondViewController.swift
//  Assignment4
//
//  Created by Micah Reid on 7/15/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//
//All Icons from https://icons8.com/
import UIKit

class SimulationViewController: UIViewController, EngineDelegateProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func engineDidUpdate(withGrid: GridProtocol) {
        GridView(grid: withGrid)
    }
}

