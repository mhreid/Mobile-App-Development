//
//  TableViewController.swift
//  FinalProject
//
//  Created by Micah Reid on 8/2/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var names:Array<String> = ["ha", "ha"]
    static let tableView = TableViewController()
    var url: NSURL?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
  /*  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = ConfigCell()

        let row = indexPath.row
        cell.name.text = names[row]
        //cell.tag = row
        return cell
        
        
    }*/

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            names.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath],
                                             withRowAnimation: .Automatic)
        }
    }
    
    
    
    /*override func viewDidAppear(animated: Bool) {
     let fetcher = Fetcher()
     if url != nil{
     fetcher.requestJSON(url!) { (json, message) in
     if let json = json,
     dict = json as? Dictionary<String,AnyObject> {
     let keys = dict.keys
     self.names = Array(keys)
     let op = NSBlockOperation {
     self.tableView.reloadData()
     }
     NSOperationQueue.mainQueue().addOperation(op)
     }
     }
     }
     }*/

}
