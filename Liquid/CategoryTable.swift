//
//  ProductTable.swift
//  Liquid
//
//  Created by Pavan Powani on 6/16/16.
//  Copyright © 2016 Powani. All rights reserved.
//

import Foundation
import UIKit

class CategoryTableView:UITableViewController {
    
    var filteredProjects = [ProjectModel]()
     var projects = [ProjectModel]()
    let searchController = UISearchController(searchResultsController: nil)
    var selectedCategory: String = ""
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    var Categories = ["Assets & Wealth Managaement","Banking","Commercial","Healthcare","Life Sciences","Insurance"]
    
     override func viewDidLoad() {

        
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        myTableView.tableHeaderView = searchController.searchBar
    }
    
    
     //tableview methods
     override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredProjects.count
        }
        return Categories.count
    }
    
     override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Category", forIndexPath: indexPath) as! CategoryCell
        // var project: ProjectModel
        
    //    if searchController.active && searchController.searchBar.text != "" {
    //        project = filteredProjects[indexPath.row]
    //        cell.pName.text = project.projectName
    //    } else {
     //       project = projects[indexPath.row]
            cell.categoryName.text = Categories[indexPath.row]
     //   }
        
        
        return cell
    }
    
    
    //search methods
    func searchDisplayController(controller: UISearchController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        return true
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
            filteredProjects = projects.filter({ (project: ProjectModel) -> Bool in
                return project.projectName.lowercaseString.containsString(searchText.lowercaseString)
            })
        
        myTableView.reloadData()
    }
    @IBAction func cancelToTableView(segue:UIStoryboardSegue) {
    }

 
}
extension CategoryTableView: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
        myTableView.reloadData()
    }
}
