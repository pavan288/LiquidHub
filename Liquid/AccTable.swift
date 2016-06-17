//
//  ProductTable.swift
//  Liquid
//
//  Created by Pavan Powani on 6/16/16.
//  Copyright © 2016 Powani. All rights reserved.
//

import Foundation
import UIKit

class AcceleratorTableView: UITableViewController {
    
    var filteredAcc = [AcceleratorModel]()
    var accelerators = [AcceleratorModel]()
    
    
     override func viewDidLoad() {
        
        accelerators = [
            AcceleratorModel(acceleratorName:"Acc1", acceleratorId: 1),
            AcceleratorModel(acceleratorName:"Acc2", acceleratorId: 2),
            AcceleratorModel(acceleratorName:"Acc1", acceleratorId: 3),
            AcceleratorModel(acceleratorName:"Acc2", acceleratorId: 4),
            AcceleratorModel(acceleratorName:"Acc1", acceleratorId: 5),
            AcceleratorModel(acceleratorName:"Acc2", acceleratorId: 6),
            AcceleratorModel(acceleratorName:"Acc1", acceleratorId: 7),
            AcceleratorModel(acceleratorName:"Acc2", acceleratorId: 8),
            AcceleratorModel(acceleratorName:"Acc1", acceleratorId: 9)
        ]
    }
    
     override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 0
        returnValue = accelerators.count
        return returnValue
    }
    
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let accelerator: AcceleratorModel
        
        accelerator = accelerators[indexPath.row]
        cell.textLabel!.text = accelerator.acceleratorName
        
        return cell
    }
}

