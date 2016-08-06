//
//  GridEditorController.swift
//  FinalProject
//
//  Created by Micah Reid on 8/4/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//

import UIKit

class GridEditorController: UIViewController{
    static let gridEditor: GridEditorController = GridEditorController()
    @IBOutlet weak var saveName: UITextField!
    @IBAction func go(sender: AnyObject) {
        grid.setNeedsDisplay()
    }
    @IBOutlet weak var grid: EditGridView!
    override func viewDidLoad() {
        grid.points = StandardEngine.sharedInstance.editPoints
    }
    @IBAction func save(sender: AnyObject) {
        TableViewController.tableView.tableContents["Blinker"] = grid.getPoints()
    }

}