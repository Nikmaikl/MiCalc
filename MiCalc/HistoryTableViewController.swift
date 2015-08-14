//
//  HistoryTableViewController.swift
//  MiCalc
//
//  Created by Michael on 11.08.15.
//  Copyright © 2015 Ocode. All rights reserved.
//

import UIKit

class HistoryTableViewController : UITableViewController {
    
    var operations = Array<String>()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return operations.count
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        cell!.textLabel!.text = operations[indexPath.row]
        
        return cell!
    }
}
