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
        StandardEngine.sharedInstance.tableContents[saveName.text!] = grid.getPoints()
        StandardEngine.sharedInstance.names.append(saveName.text!)
    }
    @IBOutlet weak var grid: EditGridView!
    override func viewDidLoad() {
        grid.points = StandardEngine.sharedInstance.editPoints
    }
    func blah() {
        StandardEngine.sharedInstance.tableContents[StandardEngine.sharedInstance.names[StandardEngine.sharedInstance.editRow]] = grid.getPoints()
    }
    @IBAction func load(sender: AnyObject) {
        var newPoints: [(Int, Int)] = []
        _ = grid.getPoints().map{
            newPoints.append(($0[0], $0[1]))
        }
       StandardEngine.sharedInstance.gridView.points = newPoints
        performSegueWithIdentifier("loadSegue", sender: self)
    }

    @IBAction func save(sender: UIBarButtonItem) {
        StandardEngine.sharedInstance.tableContents[StandardEngine.sharedInstance.names[StandardEngine.sharedInstance.editRow]] = grid.getPoints()
        performSegueWithIdentifier("saveSegue", sender: self)
    }



}