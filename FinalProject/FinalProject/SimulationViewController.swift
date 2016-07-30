//
//  SimulationViewController.swift
//  FinalProject
//
//  Created by Micah Reid on 7/28/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController, EngineDelegate {

    @IBOutlet weak var grid: GridView!
    @IBAction func step(sender: AnyObject) {
        StandardEngine.sharedInstance.step()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StandardEngine.sharedInstance.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func engineDidUpdate(withGrid: GridProtocol){
        grid.grid = withGrid
    }


}

