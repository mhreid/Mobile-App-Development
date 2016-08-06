//
//  TableViewController.swift
//  FinalProject
//
//  Created by Micah Reid on 8/2/16.
//  Copyright © 2016 Micah Reid. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var names: Array<String> = ["Blinker", "Pentadecthlon", "Glider Gun", "Tumbler"]
    var newPoints: [(Int, Int)] = []
    var tableContents: Dictionary<String,[[Int]]> = StandardEngine.sharedInstance.tableContents

    static let tableView = TableViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    //help from http://www.codingexplorer.com/segue-uitableviewcell-taps-swift/
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if  segue.identifier == "sendToGridSegue",
            let tableRow = tableView.indexPathForSelectedRow?.row
        {
            _ = tableContents[names[tableRow]]!.reduce(0){
                newPoints.append(($0.1[0], $0.1[1]))
                return 0
            }
            StandardEngine.sharedInstance.editRow = tableRow
        }
        StandardEngine.sharedInstance.editPoints = newPoints
    }

    
    /* override func viewDidAppear(animated: Bool) {
        let url = NSURL(string: "https://dl.dropboxusercontent.com/u/7544475/S65g.json")!
        let fetcher = Fetcher()
        
        fetcher.requestJSON(url) { (json, message) in
            if let json = json,
                dict = json as? Array<Dictionary<String,AnyObject>> {
                self.names = []
                _ = dict.reduce(0){
                    if let name = $1["title"] as? String, points = $1["contents"] as? [[Int]]{
                      self.names.append(name)
                        self.tableContents[name] = points
                    }
                    return 1
                }
                let op = NSBlockOperation {
                    self.tableView.reloadData()
                }
                NSOperationQueue.mainQueue().addOperation(op)
            }

        }
        print (names)
        print (tableContents)
    } */
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
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
        nameLabel.text = names[row]
        cell.tag = row
        return cell
        
        
    }
    
    /*override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
     if editingStyle == .Delete {
     names.removeAtIndex(indexPath.row)
     tableView.deleteRowsAtIndexPaths([indexPath],
     withRowAnimation: .Automatic)
     }
     }*/
    
    


}





