//
//  ProductTable.swift
//  Liquid
//
//  Created by Pavan Powani on 6/16/16.
//  Copyright © 2016 Powani. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class AcceleratorTableView: UITableViewController {
    
    var filteredAcc = [AcceleratorModel]()
    var accelerators = [AcceleratorModel]()
    let searchController = UISearchController(searchResultsController: nil)
    let urlString = "http://54.169.229.225:8080/LEM/lem/api/login/homePage"
    var NumberOfRows = 0
    
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
        searchController.hidesNavigationBarDuringPresentation = false

        
        parseJSON()
    }
    
    func parseJSON(){
        
        let url = NSURL(string: urlString)
        let jsonData = try? NSData(contentsOfURL: url!, options: [])
        let readableJSON = JSON(data: jsonData!, options: NSJSONReadingOptions.MutableContainers, error: nil)
        NumberOfRows = readableJSON.count
        let accelerator = AcceleratorModel(acceleratorName: "",acceleratorId: 0)

        
        for i in 0...(NumberOfRows-1){
            accelerator.acceleratorName = readableJSON[i]["name"].string! as String
            accelerator.acceleratorId = readableJSON[i]["id"].int!
            accelerators.append(AcceleratorModel(acceleratorName: "\(accelerator.acceleratorName)",acceleratorId: accelerator.acceleratorId))
        }
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

