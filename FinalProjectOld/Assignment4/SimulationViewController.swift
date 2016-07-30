//
//  SecondViewController.swift
//  Assignment4
//
//  Created by Micah Reid on 7/15/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//
//All Icons from https://icons8.com/
import UIKit

class SimulationViewController: UIViewController, EngineDelegate {
    var grid: Grid = Grid(20, 20)
    //let gridView: GridView = GridView(grid: grid)
    
    @IBOutlet weak var gridView: GridView!
    @objc func doSomething() {
        gridView.grid = self.grid
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        engineDidUpdate(grid)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func engineDidUpdate(withGrid: Grid) {
        /*let sel = #selector(ViewController.watchForNotifications(_:))
        let center  = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: sel, name: "ExampleNotification", object: nil)*/
        
        //let sel = #selector(gridView.setGrid(grid))
        let center = NSNotificationCenter.defaultCenter()
        //center.addObserver(gridView, selector: #selector((gridView.setGrid(grid))), name: "GridSent", object: nil)
        center.addObserver(self, selector: #selector(doSomething), name: "GridSent", object: nil)
        
    }
}

