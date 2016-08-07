//
//  TableViewController.swift
//  FinalProject
//
//  Created by Micah Reid on 8/2/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var newPoints: [(Int, Int)] = []

    static let tableView = TableViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    //help from http://www.codingexplorer.com/segue-uitableviewcell-taps-swift/
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print(StandardEngine.sharedInstance.names)
        if  segue.identifier == "sendToGridSegue",
            let tableRow = tableView.indexPathForSelectedRow?.row
        {
            if StandardEngine.sharedInstance.tableContents[StandardEngine.sharedInstance.names[tableRow]]! != [[]]{
            _ = StandardEngine.sharedInstance.tableContents[StandardEngine.sharedInstance.names[tableRow]]!.reduce(0){
                newPoints.append(($0.1[0], $0.1[1]))
                return 0
                }}
            StandardEngine.sharedInstance.editRow = tableRow
        }
        StandardEngine.sharedInstance.editPoints = newPoints
    }

    override func viewDidAppear(animated: Bool) {
            self.tableView.reloadData()
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StandardEngine.sharedInstance.names.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("ConfigCell")
            else {
                preconditionFailure("missing Default reuse identifier")
        }
        let row = indexPath.row
        guard let nameLabel = cell.textLabel else {
            preconditionFailure("wtf?")
        }
        nameLabel.text = StandardEngine.sharedInstance.names[row]
        cell.tag = row
        return cell
        
        
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
        StandardEngine.sharedInstance.tableContents.removeValueForKey(StandardEngine.sharedInstance.names[indexPath.row])
        StandardEngine.sharedInstance.names.removeAtIndex(indexPath.row)
     tableView.deleteRowsAtIndexPaths([indexPath],
     withRowAnimation: .Automatic)
     }
     }
    
    


}





