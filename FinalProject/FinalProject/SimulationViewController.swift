//
//  SimulationViewController.swift
//  FinalProject
//
//  Created by Micah Reid on 7/28/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController, EngineDelegate {
    static let simulation: SimulationViewController = SimulationViewController()
    @IBOutlet weak var grid: GridView!
    @IBAction func step(sender: AnyObject) {
        StandardEngine.sharedInstance.step()
    }
    @IBOutlet weak var reset: UIButton!
    
    @IBAction func reset(sender: AnyObject) {
        StandardEngine.sharedInstance.gridView.points = []
        StandardEngine.sharedInstance.step()
    }
    @IBOutlet weak var mutate: UISwitch!
    
    @IBAction func mutate(sender: AnyObject) {
        StandardEngine.sharedInstance.mutate = mutate.on
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

