//
//  SegmentedView.swift
//  Liquid
//
//  Created by Pavan Powani on 6/15/16.
//  Copyright © 2016 Powani. All rights reserved.
//

import Foundation
import UIKit

class SegmentedView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //outlets
  //  @IBOutlet weak var searchController: UISearchController!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var myTableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    var filteredTableData = [String]()
    
    //dummy value arrays
    
    let Projects:[String] = ["Project1","Project2","Project3","Project4"]
    let Accelerators:[String] = ["Acc1","Acc2","Acc3","Acc4"]
    let Clients:[String] = ["Client1","Client2","Client3","Cient4"]

    //search across segments
    override func viewDidLoad() {
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        myTableView.tableHeaderView = searchController.searchBar
    }
    
    func searchDisplayController(controller: UISearchController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        return true
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        switch(segmentedControl.selectedSegmentIndex){
        case 0:
            filteredTableData = Projects.filter { project in
                        return project.lowercaseString.containsString(searchText.lowercaseString)
            }
            break
        case 1:
            filteredTableData = Accelerators.filter { project in
                return project.lowercaseString.containsString(searchText.lowercaseString)
            }
            break
        case 2:
            filteredTableData = Clients.filter { project in
                return project.lowercaseString.containsString(searchText.lowercaseString)
                
            }
            break
        default:
            break
        }

        
        
        myTableView.reloadData()
    }
    
    
    
    //method implementation
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        var returnValue = 0
        
        
        if (self.searchController.active) {
            return self.filteredTableData.count
        }
        else {
        switch(segmentedControl.selectedSegmentIndex){
        case 0:
            returnValue = Projects.count
            break
        case 1:
            returnValue = Accelerators.count
            break
        case 2:
            returnValue = Clients.count
            break
        default:
            break
        }
        
        return returnValue
    }
    }
    func indexChanged(sender: AnyObject) {
        
        myTableView.reloadData()
        
        
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell!
        
      if (self.searchController.active) {
            cell.textLabel?.text = filteredTableData[indexPath.row]
            return cell
        }
        else {
        switch(segmentedControl.selectedSegmentIndex){
        case 0:
            cell.textLabel!.text = Projects[indexPath.row]
            break
        case 1:
            cell.textLabel!.text = Accelerators[indexPath.row]
            break
        case 2:
            cell.textLabel!.text = Clients[indexPath.row]
            break
        default:
            break
        }
        
        return cell
        
    }
    }
   

}

extension SegmentedView: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
        myTableView.reloadData()
    }
}
