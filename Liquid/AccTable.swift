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
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var myTableView: UITableView!
    
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
        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        myTableView.tableHeaderView = searchController.searchBar
    }
    
    //tableview methods
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredAcc.count
        }
        return accelerators.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! AcceleratorCell
        var accelerator: AcceleratorModel
        
        if searchController.active && searchController.searchBar.text != "" {
            accelerator = filteredAcc[indexPath.row]
            cell.aName!.text = accelerator.acceleratorName
        } else {
            accelerator = accelerators[indexPath.row]
            cell.aName!.text = accelerator.acceleratorName
        }
        
        
        return cell
    }
    
    //search methods
    func searchDisplayController(controller: UISearchController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        return true
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredAcc = accelerators.filter({ (accelerator: AcceleratorModel) -> Bool in
            return accelerator.acceleratorName.lowercaseString.containsString(searchText.lowercaseString)
        })
        
        myTableView.reloadData()
    }
    
}
extension AcceleratorTableView: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
        myTableView.reloadData()
    }
}

